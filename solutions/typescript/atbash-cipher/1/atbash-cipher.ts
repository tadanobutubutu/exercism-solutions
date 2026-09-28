export function encode(plainText: unknown): string {
  if (typeof plainText !== 'string') return ''
  const transformed = [...plainText.toLowerCase()]
    .filter((character) => /[a-z0-9]/.test(character))
    .map((character) => {
      if (character < 'a' || character > 'z') return character
      return String.fromCharCode(219 - character.charCodeAt(0))
    })
    .join('')
  return transformed.match(/.{1,5}/g)?.join(' ') ?? ''
}

export function decode(cipherText: unknown): string {
  if (typeof cipherText !== 'string') return ''
  return [...cipherText.toLowerCase()]
    .filter((character) => /[a-z0-9]/.test(character))
    .map((character) => {
      if (character < 'a' || character > 'z') return character
      return String.fromCharCode(219 - character.charCodeAt(0))
    })
    .join('')
}
