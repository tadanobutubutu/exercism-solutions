export function calculatePrimeFactors(value: number): number[] {
  if (!Number.isSafeInteger(value) || value < 1) {
    throw new Error('number must be a positive integer')
  }

  const factors: number[] = []
  let remainder = value
  for (let divisor = 2; divisor * divisor <= remainder; divisor++) {
    while (remainder % divisor === 0) {
      factors.push(divisor)
      remainder /= divisor
    }
  }
  if (remainder > 1) factors.push(remainder)
  return factors
}
