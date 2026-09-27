export function isArmstrongNumber(value: unknown): boolean {
  let number: bigint
  if (typeof value === 'bigint') {
    number = value
  } else if (typeof value === 'number' && Number.isSafeInteger(value) && value >= 0) {
    number = BigInt(value)
  } else {
    return false
  }

  const digits = number.toString()
  const power = BigInt(digits.length)
  const sum = [...digits].reduce(
    (total, digit) => total + BigInt(digit) ** power,
    0n
  )
  return sum === number
}
