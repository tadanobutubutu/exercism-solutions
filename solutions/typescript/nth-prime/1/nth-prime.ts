export function nth(position: number): number {
  if (!Number.isInteger(position) || position < 1) {
    throw new Error('Prime is not possible')
  }

  const primes: number[] = []
  for (let candidate = 2; primes.length < position; candidate++) {
    let prime = true
    for (const divisor of primes) {
      if (divisor * divisor > candidate) break
      if (candidate % divisor === 0) {
        prime = false
        break
      }
    }
    if (prime) primes.push(candidate)
  }
  return primes[position - 1]!
}
