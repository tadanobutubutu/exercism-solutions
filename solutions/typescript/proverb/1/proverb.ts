export function proverb(...words: string[]): string {
  if (words.length === 0) return ''

  const lines = words.slice(0, -1).map((word, index) =>
    `For want of a ${word} the ${words[index + 1]} was lost.`
  )
  lines.push(`And all for the want of a ${words[0]}.`)
  return lines.join('\n')
}
