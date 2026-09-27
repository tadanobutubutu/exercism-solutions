//
// This is only a SKELETON file for the 'Pop Count' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const eggCount = (displayValue: unknown): number => {
  let remaining: bigint
  if (typeof displayValue === 'bigint') {
    remaining = displayValue
  } else if (
    typeof displayValue === 'number' &&
    Number.isSafeInteger(displayValue) &&
    displayValue >= 0
  ) {
    remaining = BigInt(displayValue)
  } else {
    throw new Error('invalid display value')
  }

  let eggs = 0
  while (remaining > 0n) {
    if (remaining % 2n === 1n) eggs++
    remaining /= 2n
  }
  return eggs
}
