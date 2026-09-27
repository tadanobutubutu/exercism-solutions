export function rotate(text: string, key: number): string {
  const shift = ((key % 26) + 26) % 26
  return [...text]
    .map((character) => {
      const code = character.charCodeAt(0)
      const base = code >= 65 && code <= 90 ? 65 : code >= 97 && code <= 122 ? 97 : 0
      return base === 0
        ? character
        : String.fromCharCode(((code - base + shift) % 26) + base)
    })
    .join('')
}
