export class Matrix {
  private readonly data: number[][]

  constructor(source: string) {
    this.data = source.split('\n').map((line) =>
      line
        .trim()
        .split(/\s+/)
        .map(Number),
    )
  }

  get rows(): number[][] {
    return this.data.map((row) => [...row])
  }

  get columns(): number[][] {
    return this.data[0].map((_, columnIndex) =>
      this.data.map((row) => row[columnIndex]),
    )
  }
}
