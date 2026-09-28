export function primes(limit: number): number[] {
  if (limit < 2) return []
  const isPrime = Array<boolean>(limit + 1).fill(true)
  isPrime[0] = false
  isPrime[1] = false
  for (let candidate = 2; candidate * candidate <= limit; candidate++) {
    if (!isPrime[candidate]) continue
    for (let multiple = candidate * candidate; multiple <= limit; multiple += candidate) {
      isPrime[multiple] = false
    }
  }
  const result: number[] = []
  for (let number = 2; number <= limit; number++) {
    if (isPrime[number]) result.push(number)
  }
  return result
}
