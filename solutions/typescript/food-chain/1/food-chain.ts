const animals = ['fly', 'spider', 'bird', 'cat', 'dog', 'goat', 'cow', 'horse']

const reactions = [
  '',
  'It wriggled and jiggled and tickled inside her.',
  'How absurd to swallow a bird!',
  'Imagine that, to swallow a cat!',
  'What a hog, to swallow a dog!',
  'Just opened her throat and swallowed a goat!',
  "I don't know how she swallowed a cow!",
  "She's dead, of course!",
]

function verse(number: number): string {
  if (!Number.isInteger(number) || number < 1 || number > animals.length) {
    throw new RangeError('Verse number must be between 1 and 8')
  }

  const animal = animals[number - 1]
  const lines = [`I know an old lady who swallowed a ${animal}.`, reactions[number - 1]]

  if (number === 8) return `${lines.join('\n')}\n`

  for (let index = number - 1; index > 0; index--) {
    const swallowed = animals[index]
    const next = animals[index - 1]
    const suffix = swallowed === 'bird' ? ' that wriggled and jiggled and tickled inside her' : ''
    lines.push(`She swallowed the ${swallowed} to catch the ${next}${suffix}.`)
  }

  lines.push("I don't know why she swallowed the fly. Perhaps she'll die.")
  return `${lines.filter(Boolean).join('\n')}\n`
}

export { verse }

export function verses(start: number, end: number): string {
  const result: string[] = []
  for (let number = start; number <= end; number++) result.push(verse(number))
  return result.join('\n')
}
