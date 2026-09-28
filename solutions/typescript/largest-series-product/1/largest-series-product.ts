export const largestProduct = (digits: string, span: number): number => {
  if (!Number.isInteger(span) || span < 0) {
    throw new Error('Span must not be negative')
  }
  if (span > digits.length) {
    throw new Error('Span must not exceed string length')
  }
  if (!/^\d*$/.test(digits)) {
    throw new Error('Digits input must only contain digits')
  }
  if (span === 0) return 1

  const numbers = [...digits].map(Number)
  let maximum = 0
  for (let start = 0; start <= numbers.length - span; start++) {
    let product = 1
    for (let index = start; index < start + span; index++) {
      product *= numbers[index]
    }
    maximum = Math.max(maximum, product)
  }
  return maximum
}
