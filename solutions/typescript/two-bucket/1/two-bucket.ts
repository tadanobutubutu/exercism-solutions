type Bucket = 'one' | 'two'
type State = { one: number; two: number; moves: number }

export class TwoBucket {
  private goalBucketValue: Bucket | undefined
  private otherBucketValue: number | undefined
  private moveCount: number | undefined

  constructor(
    private readonly sizeOne: number,
    private readonly sizeTwo: number,
    private readonly goal: number,
    private readonly startBucket: Bucket
  ) {}

  moves(): number {
    this.solve()
    return this.moveCount!
  }

  get goalBucket(): Bucket {
    this.solve()
    return this.goalBucketValue!
  }

  get otherBucket(): number {
    this.solve()
    return this.otherBucketValue!
  }

  private solve(): void {
    if (this.moveCount !== undefined) return
    if (
      !Number.isInteger(this.sizeOne) ||
      !Number.isInteger(this.sizeTwo) ||
      this.sizeOne <= 0 ||
      this.sizeTwo <= 0 ||
      !Number.isInteger(this.goal) ||
      this.goal < 0 ||
      this.goal > Math.max(this.sizeOne, this.sizeTwo)
    ) {
      throw new Error('cannot measure the requested amount')
    }

    const initial: State =
      this.startBucket === 'one'
        ? { one: this.sizeOne, two: 0, moves: 1 }
        : { one: 0, two: this.sizeTwo, moves: 1 }
    const queue: State[] = [initial]
    const visited = new Set([`${initial.one},${initial.two}`])

    for (let cursor = 0; cursor < queue.length; cursor++) {
      const state = queue[cursor]
      if (state.one === this.goal || state.two === this.goal) {
        this.moveCount = state.moves
        this.goalBucketValue = state.one === this.goal ? 'one' : 'two'
        this.otherBucketValue =
          this.goalBucketValue === 'one' ? state.two : state.one
        return
      }

      const nextStates = this.nextStates(state)
      for (const [one, two] of nextStates) {
        const forbidden =
          this.startBucket === 'one'
            ? one === 0 && two === this.sizeTwo
            : two === 0 && one === this.sizeOne
        if (forbidden) continue
        const key = `${one},${two}`
        if (visited.has(key)) continue
        visited.add(key)
        queue.push({ one, two, moves: state.moves + 1 })
      }
    }
    throw new Error('cannot measure the requested amount')
  }

  private nextStates({ one, two }: State): [number, number][] {
    const fillStart =
      this.startBucket === 'one'
        ? [this.sizeOne, two] as [number, number]
        : [one, this.sizeTwo] as [number, number]
    const pourStart =
      this.startBucket === 'one'
        ? (() => {
            const amount = Math.min(one, this.sizeTwo - two)
            return [one - amount, two + amount] as [number, number]
          })()
        : (() => {
            const amount = Math.min(two, this.sizeOne - one)
            return [one + amount, two - amount] as [number, number]
          })()
    const emptyOther =
      this.startBucket === 'one'
        ? [one, 0] as [number, number]
        : [0, two] as [number, number]
    const fillOther =
      this.startBucket === 'one'
        ? [one, this.sizeTwo] as [number, number]
        : [this.sizeOne, two] as [number, number]
    const pourOther =
      this.startBucket === 'one'
        ? (() => {
            const amount = Math.min(two, this.sizeOne - one)
            return [one + amount, two - amount] as [number, number]
          })()
        : (() => {
            const amount = Math.min(one, this.sizeTwo - two)
            return [one - amount, two + amount] as [number, number]
          })()
    const emptyStart =
      this.startBucket === 'one'
        ? [0, two] as [number, number]
        : [one, 0] as [number, number]
    return [fillStart, pourStart, emptyOther, fillOther, pourOther, emptyStart]
  }
}
