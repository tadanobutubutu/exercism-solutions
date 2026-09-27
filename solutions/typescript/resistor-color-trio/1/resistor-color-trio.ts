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

export function decodedResistorValue(bands: string[]): string {
  const firstTwoDigits = bands
    .slice(0, 2)
    .map((color) => COLORS.indexOf(color))
    .join('')
  const value = Number(firstTwoDigits) * 10 ** COLORS.indexOf(bands[2])

  if (value >= 1_000_000_000) return `${value / 1_000_000_000} gigaohms`
  if (value >= 1_000_000) return `${value / 1_000_000} megaohms`
  if (value >= 1_000) return `${value / 1_000} kiloohms`
  return `${value} ohms`
}
