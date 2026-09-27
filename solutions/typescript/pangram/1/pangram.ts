export function isPangram(sentence: string): boolean {
  const letters = new Set(sentence.toLowerCase().match(/[a-z]/g) ?? [])
  return letters.size === 26
}
