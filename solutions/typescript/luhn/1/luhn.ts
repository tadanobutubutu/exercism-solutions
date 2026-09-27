export function valid(digitString: unknown): boolean {
  if (typeof digitString !== 'string') return false
  const digits = digitString.replace(/ /g, '')
  if (digits.length <= 1 || !/^\d+$/.test(digits)) return false

  let sum = 0
  let doubleNext = false
  for (let index = digits.length - 1; index >= 0; index--) {
    let value = Number(digits[index])
    if (doubleNext) {
      value *= 2
      if (value > 9) value -= 9
    }
    sum += value
    doubleNext = !doubleNext
  }
  return sum % 10 === 0
}
