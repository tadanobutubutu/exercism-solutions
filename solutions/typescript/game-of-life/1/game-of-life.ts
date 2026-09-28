export class GameOfLife {
  private matrix: number[][]

  constructor(matrix: unknown) {
    this.matrix = Array.isArray(matrix)
      ? matrix.map((row) => Array.isArray(row) ? [...row] as number[] : [])
      : []
  }

  public tick(): void {
    const rows = this.matrix.length
    const columns = this.matrix[0]?.length ?? 0
    const next = Array.from({ length: rows }, () => Array<number>(columns).fill(0))

    for (let row = 0; row < rows; row++) {
      for (let column = 0; column < columns; column++) {
        let neighbors = 0
        for (let rowOffset = -1; rowOffset <= 1; rowOffset++) {
          for (let columnOffset = -1; columnOffset <= 1; columnOffset++) {
            if (rowOffset === 0 && columnOffset === 0) continue
            if (this.matrix[row + rowOffset]?.[column + columnOffset] === 1) neighbors++
          }
        }
        const alive = this.matrix[row]?.[column] === 1
        if (neighbors === 3 || (alive && neighbors === 2)) next[row]![column] = 1
      }
    }
    this.matrix = next
  }

  public state(): number[][] {
    return this.matrix.map((row) => [...row])
  }
}
