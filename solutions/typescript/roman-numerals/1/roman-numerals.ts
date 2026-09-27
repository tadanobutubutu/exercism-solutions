export const toRoman = (value: number): string => {
  if (!Number.isInteger(value) || value < 1 || value > 3999) {
    throw new RangeError('Roman numerals can represent integers from 1 to 3999.')
  }

  const symbols: [number, string][] = [
    [1000, 'M'],
    [900, 'CM'],
    [500, 'D'],
    [400, 'CD'],
    [100, 'C'],
    [90, 'XC'],
    [50, 'L'],
    [40, 'XL'],
    [10, 'X'],
    [9, 'IX'],
    [5, 'V'],
    [4, 'IV'],
    [1, 'I'],
  ]

  let remainder = value
  let result = ''
  for (const [amount, symbol] of symbols) {
    while (remainder >= amount) {
      result += symbol
      remainder -= amount
    }
  }
  return result
}
