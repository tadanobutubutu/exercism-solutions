export function annotate(field: unknown): string[] {
  if (!Array.isArray(field) || field.some((row) => typeof row !== 'string')) {
    throw new Error('Invalid field')
  }
  const rows = field as string[]
  return rows.map((row, rowIndex) => {
    let annotated = ''
    for (let column = 0; column < row.length; column++) {
      if (row[column] === '*') {
        annotated += '*'
        continue
      }

      let flowers = 0
      for (let rowOffset = -1; rowOffset <= 1; rowOffset++) {
        for (let columnOffset = -1; columnOffset <= 1; columnOffset++) {
          if (rowOffset === 0 && columnOffset === 0) continue
          if (rows[rowIndex + rowOffset]?.[column + columnOffset] === '*') flowers++
        }
      }
      annotated += flowers === 0 ? ' ' : String(flowers)
    }
    return annotated
  })
}
