export function count(rows: string[]): number {
  let rectangles = 0
  for (let top = 0; top < rows.length; top++) {
    for (let bottom = top + 1; bottom < rows.length; bottom++) {
      for (let left = 0; left < (rows[0]?.length ?? 0); left++) {
        for (let right = left + 1; right < (rows[0]?.length ?? 0); right++) {
          if (
            rows[top]?.[left] !== '+' || rows[top]?.[right] !== '+' ||
            rows[bottom]?.[left] !== '+' || rows[bottom]?.[right] !== '+'
          ) continue

          let complete = true
          for (let column = left + 1; column < right && complete; column++) {
            const topCell = rows[top]?.[column]
            const bottomCell = rows[bottom]?.[column]
            if (!['-', '+'].includes(topCell ?? '') || !['-', '+'].includes(bottomCell ?? '')) {
              complete = false
            }
          }
          for (let row = top + 1; row < bottom && complete; row++) {
            const leftCell = rows[row]?.[left]
            const rightCell = rows[row]?.[right]
            if (!['|', '+'].includes(leftCell ?? '') || !['|', '+'].includes(rightCell ?? '')) {
              complete = false
            }
          }
          if (complete) rectangles++
        }
      }
    }
  }
  return rectangles
}
