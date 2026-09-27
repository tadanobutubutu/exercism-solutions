export class Series {
  private readonly digits: number[]

  constructor(series: unknown) {
    this.digits =
      typeof series === 'string' && /^\d*$/.test(series)
        ? [...series].map(Number)
        : []
  }

  slices(sliceLength: unknown): number[][] {
    if (this.digits.length === 0) throw new Error('series cannot be empty')
    if (typeof sliceLength !== 'number' || !Number.isInteger(sliceLength)) {
      throw new Error('slice length must be an integer')
    }
    if (sliceLength < 0) throw new Error('slice length cannot be negative')
    if (sliceLength === 0) throw new Error('slice length cannot be zero')
    if (sliceLength > this.digits.length) {
      throw new Error('slice length cannot be greater than series length')
    }

    const result: number[][] = []
    for (let start = 0; start <= this.digits.length - sliceLength; start++) {
      result.push(this.digits.slice(start, start + sliceLength))
    }
    return result
  }
}
