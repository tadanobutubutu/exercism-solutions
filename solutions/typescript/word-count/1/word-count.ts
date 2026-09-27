export function count(phrase: string): Map<string, number> {
  const words = phrase.toLowerCase().match(/[a-z0-9]+(?:'[a-z0-9]+)*/g) ?? []
  const counts = new Map<string, number>()

  for (const word of words) {
    counts.set(word, (counts.get(word) ?? 0) + 1)
  }

  return counts
}
