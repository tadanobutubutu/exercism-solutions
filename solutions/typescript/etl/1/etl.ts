export function transform(legacy: Record<string, string[]>): Record<string, number> {
  const transformed: Record<string, number> = {}
  for (const [score, letters] of Object.entries(legacy)) {
    for (const letter of letters) {
      transformed[letter.toLowerCase()] = Number(score)
    }
  }
  return transformed
}
