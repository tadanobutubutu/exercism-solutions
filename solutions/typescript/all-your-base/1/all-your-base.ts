export function convert(
  digits: number[],
  inputBase: number,
  outputBase: number,
): number[] {
  if (!Number.isInteger(inputBase) || inputBase <= 1) {
    throw new Error('Wrong input base')
  }
  if (!Number.isInteger(outputBase) || outputBase <= 1) {
    throw new Error('Wrong output base')
  }
  if (
    digits.length === 0 ||
    (digits.length > 1 && digits[0] === 0) ||
    digits.some((digit) => !Number.isInteger(digit) || digit < 0 || digit >= inputBase)
  ) {
    throw new Error('Input has wrong format')
  }

  const sourceBase = BigInt(inputBase)
  let value = 0n
  for (const digit of digits) {
    value = value * sourceBase + BigInt(digit)
  }
  if (value === 0n) return [0]

  const targetBase = BigInt(outputBase)
  const converted: number[] = []
  while (value > 0n) {
    converted.unshift(Number(value % targetBase))
    value /= targetBase
  }
  return converted
}
