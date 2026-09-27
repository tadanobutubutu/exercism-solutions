export function classify(number: number): 'perfect' | 'abundant' | 'deficient' {
  if (!Number.isInteger(number) || number < 1) {
    throw new Error('Classification is only possible for natural numbers.')
  }

  let aliquotSum = number === 1 ? 0 : 1
  for (let divisor = 2; divisor * divisor <= number; divisor++) {
    if (number % divisor !== 0) continue
    aliquotSum += divisor
    const pairedDivisor = number / divisor
    if (pairedDivisor !== divisor) aliquotSum += pairedDivisor
  }

  if (aliquotSum === number) return 'perfect'
  return aliquotSum > number ? 'abundant' : 'deficient'
}
