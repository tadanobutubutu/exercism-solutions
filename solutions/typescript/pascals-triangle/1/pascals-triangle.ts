export class Triangle {
  private readonly triangleRows: number[][] = []

  constructor(numberOfRows: unknown) {
    if (typeof numberOfRows !== 'number' || !Number.isInteger(numberOfRows)) return

    const rowCount = Math.max(0, numberOfRows)
    for (let rowIndex = 0; rowIndex < rowCount; rowIndex++) {
      const previous = this.triangleRows[rowIndex - 1]
      const row = Array.from({ length: rowIndex + 1 }, (_, column) => {
        if (column === 0 || column === rowIndex) return 1
        return previous[column - 1] + previous[column]
      })
      this.triangleRows.push(row)
    }
  }

  get rows(): number[][] {
    return this.triangleRows.map((row) => [...row])
  }

  get lastRow(): number[] {
    return [...(this.triangleRows.at(-1) ?? [])]
  }
}
