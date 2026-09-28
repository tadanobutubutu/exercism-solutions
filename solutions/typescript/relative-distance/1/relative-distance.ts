export function degreesOfSeparation(
  familyTree: unknown,
  personA: unknown,
  personB: unknown
): number {
  if (
    typeof familyTree !== 'object' ||
    familyTree === null ||
    typeof personA !== 'string' ||
    typeof personB !== 'string'
  ) return -1

  const graph = new Map<string, Set<string>>()
  const connect = (first: string, second: string): void => {
    if (!graph.has(first)) graph.set(first, new Set())
    if (!graph.has(second)) graph.set(second, new Set())
    graph.get(first)!.add(second)
    graph.get(second)!.add(first)
  }

  for (const [parent, rawChildren] of Object.entries(familyTree)) {
    if (!Array.isArray(rawChildren)) continue
    const children = rawChildren.filter((child): child is string => typeof child === 'string')
    for (const child of children) connect(parent, child)
    for (let first = 0; first < children.length; first++) {
      for (let second = first + 1; second < children.length; second++) {
        connect(children[first]!, children[second]!)
      }
    }
  }

  if (personA === personB) return graph.has(personA) ? 0 : -1
  if (!graph.has(personA) || !graph.has(personB)) return -1

  const queue: [string, number][] = [[personA, 0]]
  const visited = new Set([personA])
  for (let index = 0; index < queue.length; index++) {
    const [person, distance] = queue[index]!
    for (const relative of graph.get(person)!) {
      if (relative === personB) return distance + 1
      if (!visited.has(relative)) {
        visited.add(relative)
        queue.push([relative, distance + 1])
      }
    }
  }
  return -1
}
