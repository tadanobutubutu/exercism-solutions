export function score(x: number, y: number): number {
  const distanceSquared = x * x + y * y
  if (distanceSquared <= 1) return 10
  if (distanceSquared <= 25) return 5
  if (distanceSquared <= 100) return 1
  return 0
}
