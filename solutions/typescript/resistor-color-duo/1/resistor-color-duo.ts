const COLORS = [
  'black',
  'brown',
  'red',
  'orange',
  'yellow',
  'green',
  'blue',
  'violet',
  'grey',
  'white',
]

export function decodedValue(bands: string[]): number {
  const firstTwoDigits = bands
    .slice(0, 2)
    .map((color) => COLORS.indexOf(color))
    .join('')
  return Number(firstTwoDigits)
}
