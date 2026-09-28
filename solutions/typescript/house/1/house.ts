const items = [
  'the house that Jack built.',
  'malt',
  'rat',
  'cat',
  'dog',
  'cow with the crumpled horn',
  'maiden all forlorn',
  'man all tattered and torn',
  'priest all shaven and shorn',
  'rooster that crowed in the morn',
  'farmer sowing his corn',
  'horse and the hound and the horn',
]

const relations = [
  '',
  'that lay in',
  'that ate',
  'that killed',
  'that worried',
  'that tossed',
  'that milked',
  'that kissed',
  'that married',
  'that woke',
  'that kept',
  'that belonged to',
]

export function verse(number: number): string[] {
  if (!Number.isInteger(number) || number < 1 || number > items.length) {
    throw new RangeError('verse must be between 1 and 12')
  }
  const lines = [
    number === 1 ? `This is ${items[0]}` : `This is the ${items[number - 1]}`,
  ]
  for (let index = number - 1; index >= 1; index--) {
    const previous = index - 1 === 0 ? items[0] : `the ${items[index - 1]}`
    lines.push(`${relations[index]} ${previous}`)
  }
  return lines
}

export function verses(start: number, end: number): string[] {
  if (
    !Number.isInteger(start) ||
    !Number.isInteger(end) ||
    start < 1 ||
    end > items.length ||
    start > end
  ) {
    throw new RangeError('verse range must be between 1 and 12')
  }
  return Array.from({ length: end - start + 1 }, (_, index) =>
    verse(start + index)
  ).flatMap((lyrics, index) => (index === 0 ? lyrics : ['', ...lyrics]))
}
