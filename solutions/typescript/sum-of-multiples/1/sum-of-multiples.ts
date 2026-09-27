export function sum(factors: number[], limit: number): number {
  const multiples = new Set<number>()
  for (const factor of factors) {
    if (!Number.isInteger(factor) || factor <= 0) continue
    for (let multiple = factor; multiple < limit; multiple += factor) {
      multiples.add(multiple)
    }
  }
  return [...multiples].reduce((total, multiple) => total + multiple, 0)
}
