export function saddlePoints(matrix: unknown): { row: number; column: number }[] {
  if (!Array.isArray(matrix) || matrix.length === 0) return []
  if (!matrix.every((row) => Array.isArray(row))) return []

  const rows = matrix as number[][]
  const columnCount = rows[0]?.length ?? 0
  if (columnCount === 0 || rows.some((row) => row.length !== columnCount)) return []

  const result: { row: number; column: number }[] = []
  rows.forEach((row, rowIndex) => {
    const rowMaximum = Math.max(...row)
    for (let columnIndex = 0; columnIndex < columnCount; columnIndex++) {
      const value = row[columnIndex]
      if (
        value === rowMaximum &&
        rows.every((otherRow) => value <= otherRow[columnIndex])
      ) {
        result.push({ row: rowIndex + 1, column: columnIndex + 1 })
      }
    }
  })
  return result
}
