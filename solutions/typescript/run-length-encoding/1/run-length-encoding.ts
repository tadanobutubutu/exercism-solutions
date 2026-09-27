export function encode(input: string): string {
  const characters = [...input]
  if (characters.length === 0) return ''

  let output = ''
  let current = characters[0]
  let count = 1

  for (const character of characters.slice(1)) {
    if (character === current) {
      count++
      continue
    }
    output += `${count > 1 ? count : ''}${current}`
    current = character
    count = 1
  }
  return output + `${count > 1 ? count : ''}${current}`
}

export function decode(input: string): string {
  let output = ''
  let countText = ''

  for (const character of input) {
    if (/\d/.test(character)) {
      countText += character
      continue
    }
    const count = countText === '' ? 1 : Number(countText)
    output += character.repeat(count)
    countText = ''
  }
  return output
}
