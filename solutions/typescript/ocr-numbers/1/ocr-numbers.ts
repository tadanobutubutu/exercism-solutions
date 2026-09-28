const digits = [
  [' _ ', '| |', '|_|', '   '],
  ['   ', '  |', '  |', '   '],
  [' _ ', ' _|', '|_ ', '   '],
  [' _ ', ' _|', ' _|', '   '],
  ['   ', '|_|', '  |', '   '],
  [' _ ', '|_ ', ' _|', '   '],
  [' _ ', '|_ ', '|_|', '   '],
  [' _ ', '  |', '  |', '   '],
  [' _ ', '|_|', '|_|', '   '],
  [' _ ', '|_|', ' _|', '   '],
]

const recognizable = new Map<string, string>()
for (let digit = 0; digit < digits.length; digit++) {
  recognizable.set(digits[digit]!.join('\n'), String(digit))
}

export function convert(input: string): string {
  const lines = input.replace(/\r/g, '').split('\n')
  if (lines[lines.length - 1] === '' && input.endsWith('\n')) lines.pop()
  const width = lines[0]?.length ?? 0
  if (
    lines.length === 0 || lines.length % 4 !== 0 || width === 0 || width % 3 !== 0 ||
    lines.some((line) => line.length !== width)
  ) throw new Error('Invalid input')

  const results: string[] = []
  for (let group = 0; group < lines.length; group += 4) {
    let number = ''
    for (let column = 0; column < width; column += 3) {
      const pattern = lines.slice(group, group + 4)
        .map((line) => line.slice(column, column + 3))
        .join('\n')
      number += recognizable.get(pattern) ?? '?'
    }
    results.push(number)
  }
  return results.join(',')
}
