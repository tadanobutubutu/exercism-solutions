export function parse(phrase: unknown): string {
  if (typeof phrase !== 'string') return ''

  const words = phrase
    .replace(/([a-z0-9])([A-Z])/g, '$1 $2')
    .replace(/-/g, ' ')
    .replace(/[^a-zA-Z0-9\s]/g, '')
    .trim()
    .split(/\s+/)
    .filter(Boolean)

  return words.map((word) => word[0].toUpperCase()).join('')
}
