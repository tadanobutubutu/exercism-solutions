export function transpose(rows: string[]): string[] {
  const width = rows.reduce((longest, row) => Math.max(longest, row.length), 0)
  const result: string[] = []

  for (let column = 0; column < width; column++) {
    let lastPresentRow = -1
    for (let row = 0; row < rows.length; row++) {
      if (column < rows[row].length) lastPresentRow = row
    }

    let transposed = ''
    for (let row = 0; row <= lastPresentRow; row++) {
      transposed += rows[row][column] ?? ' '
    }
    result.push(transposed)
  }

  return result
}
