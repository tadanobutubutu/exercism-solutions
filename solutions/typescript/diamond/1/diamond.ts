export function makeDiamond(character: unknown): string {
  if (typeof character !== 'string' || !/^[A-Z]$/.test(character)) {
    throw new Error('Invalid character')
  }

  const widest = character.charCodeAt(0) - 65
  const rows: string[] = []
  for (let row = 0; row <= widest * 2; row++) {
    const letterIndex = row <= widest ? row : widest * 2 - row
    const letter = String.fromCharCode(65 + letterIndex)
    const padding = ' '.repeat(widest - letterIndex)
    const center = letterIndex === 0
      ? letter
      : `${letter}${' '.repeat(letterIndex * 2 - 1)}${letter}`
    rows.push(`${padding}${center}${padding}`)
  }
  return `${rows.join('\n')}\n`
}
