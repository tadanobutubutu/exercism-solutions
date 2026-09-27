export function isIsogram(phrase: string): boolean {
  const letters = phrase.toLowerCase().match(/[a-z]/g) ?? []
  return new Set(letters).size === letters.length
}
