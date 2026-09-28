type EqualFn<T> = (lhs: T, rhs: T) => boolean
type GetterFn<T> = () => T
type SetterFn<T> = (value: T) => T
type UnsubscribeFn = () => void
type UpdateFn<T> = (value?: T) => T
type Options = { name?: string }

type Cell = {
  value: unknown
  observers: Set<Observer>
  producer?: Observer
  equalFn?: EqualFn<unknown>
  name?: string
}

type Observer = {
  kind: 'computed' | 'callback'
  value: unknown
  updateFn: UpdateFn<unknown>
  dependencies: Set<Cell>
  output?: Cell
  equalFn?: EqualFn<unknown>
  disposed: boolean
  name?: string
}

let activeObserver: Observer | undefined
let flushing = false
const pendingRoots = new Set<Cell>()

function equality<T>(equal?: boolean | EqualFn<T>): EqualFn<unknown> | undefined {
  if (equal === true) return (lhs, rhs) => lhs === rhs
  if (typeof equal === 'function') {
    return (lhs, rhs) => equal(lhs as T, rhs as T)
  }
  return undefined
}

function read<T>(cell: Cell): T {
  if (activeObserver) {
    activeObserver.dependencies.add(cell)
    cell.observers.add(activeObserver)
  }
  return cell.value as T
}

function runObserver(observer: Observer): unknown {
  for (const dependency of observer.dependencies) {
    dependency.observers.delete(observer)
  }
  observer.dependencies.clear()

  const previousObserver = activeObserver
  activeObserver = observer
  try {
    observer.value = observer.updateFn(observer.value)
    if (observer.output) observer.output.value = observer.value
    return observer.value
  } finally {
    activeObserver = previousObserver
  }
}

function flush(roots: Set<Cell>): void {
  const computed = new Set<Observer>()
  const callbacks = new Set<Observer>()
  const visitedCells = new Set<Cell>()
  const queue = [...roots]

  // Collect the affected graph first so shared dependencies only schedule an
  // observer once and callbacks wait until every computed cell is stable.
  for (let index = 0; index < queue.length; index++) {
    const cell = queue[index]
    if (visitedCells.has(cell)) continue
    visitedCells.add(cell)
    for (const observer of cell.observers) {
      if (observer.disposed) continue
      if (observer.kind === 'callback') {
        callbacks.add(observer)
      } else if (!computed.has(observer)) {
        computed.add(observer)
        if (observer.output) queue.push(observer.output)
      }
    }
  }

  // Topologically order computed cells by their computed-cell dependencies.
  const indegree = new Map<Observer, number>()
  const dependents = new Map<Observer, Observer[]>()
  for (const observer of computed) {
    indegree.set(observer, 0)
    dependents.set(observer, [])
  }
  for (const observer of computed) {
    for (const dependency of observer.dependencies) {
      const producer = dependency.producer
      if (producer && computed.has(producer)) {
        indegree.set(observer, (indegree.get(observer) ?? 0) + 1)
        dependents.get(producer)!.push(observer)
      }
    }
  }

  const ready = [...computed].filter((observer) => indegree.get(observer) === 0)
  const ordered: Observer[] = []
  while (ready.length > 0) {
    const observer = ready.shift()!
    ordered.push(observer)
    for (const dependent of dependents.get(observer) ?? []) {
      const next = (indegree.get(dependent) ?? 0) - 1
      indegree.set(dependent, next)
      if (next === 0) ready.push(dependent)
    }
  }
  // A cycle is invalid reactive input, but processing its members once is
  // safer than leaving the graph permanently stale.
  for (const observer of computed) {
    if (!ordered.includes(observer)) ordered.push(observer)
  }

  const changedCells = new Set(roots)
  for (const observer of ordered) {
    if (![...observer.dependencies].some((dependency) => changedCells.has(dependency))) {
      continue
    }
    const previousValue = observer.value
    const nextValue = runObserver(observer)
    if (!observer.equalFn || !observer.equalFn(previousValue, nextValue)) {
      if (observer.output) changedCells.add(observer.output)
    }
  }

  for (const observer of callbacks) {
    if (
      !observer.disposed &&
      [...observer.dependencies].some((dependency) => changedCells.has(dependency))
    ) {
      runObserver(observer)
    }
  }
}

function propagate(root: Cell): void {
  pendingRoots.add(root)
  if (flushing) return

  flushing = true
  try {
    while (pendingRoots.size > 0) {
      const roots = new Set(pendingRoots)
      pendingRoots.clear()
      flush(roots)
    }
  } finally {
    flushing = false
  }
}

function createInput<T>(
  value: T,
  equal?: boolean | EqualFn<T>,
  options?: Options
): [GetterFn<T>, SetterFn<T>] {
  const cell: Cell = {
    value,
    observers: new Set(),
    equalFn: equality(equal),
    name: options?.name,
  }

  const getter: GetterFn<T> = () => read<T>(cell)
  const setter: SetterFn<T> = (nextValue) => {
    const previousValue = cell.value
    cell.value = nextValue
    if (!cell.equalFn || !cell.equalFn(previousValue, nextValue)) propagate(cell)
    return nextValue
  }
  return [getter, setter]
}

function createComputed<T>(
  updateFn: UpdateFn<T>,
  value?: T,
  equal?: boolean | EqualFn<T>,
  options?: Options
): GetterFn<T> {
  const output: Cell = {
    value,
    observers: new Set(),
    name: options?.name,
  }
  const observer: Observer = {
    kind: 'computed',
    value,
    updateFn: (previousValue) => updateFn(previousValue as T | undefined),
    dependencies: new Set(),
    output,
    equalFn: equality(equal),
    disposed: false,
    name: options?.name,
  }
  output.producer = observer
  runObserver(observer)
  return () => read<T>(output)
}

function createCallback<T>(updateFn: UpdateFn<T>, value?: T): UnsubscribeFn {
  const observer: Observer = {
    kind: 'callback',
    value,
    updateFn: (previousValue) => updateFn(previousValue as T | undefined),
    dependencies: new Set(),
    equalFn: undefined,
    disposed: false,
  }
  runObserver(observer)

  return () => {
    if (observer.disposed) return
    observer.disposed = true
    for (const dependency of observer.dependencies) {
      dependency.observers.delete(observer)
    }
    observer.dependencies.clear()
  }
}

export { createInput, createComputed, createCallback }
