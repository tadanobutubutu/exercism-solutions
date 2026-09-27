export function squareRoot(radicand: number): number {
  let low = 0
  let high = radicand
  let root = 0

  while (low <= high) {
    const middle = Math.floor((low + high) / 2)
    if (middle === 0 || middle <= radicand / middle) {
      root = middle
      low = middle + 1
    } else {
      high = middle - 1
    }
  }

  return root
}
