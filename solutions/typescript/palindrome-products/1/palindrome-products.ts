interface Input {
  maxFactor: number
  minFactor?: number
}

type FactorPair = [number, number]
type PalindromeResult = { value: number | null; factors: FactorPair[] }
type PalindromeProducts = { smallest: PalindromeResult; largest: PalindromeResult }

const isPalindrome = (value: number): boolean => {
  const digits = String(value)
  for (let left = 0, right = digits.length - 1; left < right; left++, right--) {
    if (digits[left] !== digits[right]) return false
  }
  return true
}

export function generate({ maxFactor, minFactor = 1 }: Input): PalindromeProducts {
  if (minFactor > maxFactor) throw new Error('min must be <= max')

  const factorsByProduct = new Map<number, FactorPair[]>()
  let smallest = Infinity
  let largest = -Infinity

  for (let first = minFactor; first <= maxFactor; first++) {
    for (let second = first; second <= maxFactor; second++) {
      const product = first * second
      if (product >= 10_000_000 && product < 100_000_000 && product % 11 !== 0) continue
      if (!isPalindrome(product)) continue
      const factors = factorsByProduct.get(product) ?? []
      factors.push([first, second])
      factorsByProduct.set(product, factors)
      if (product < smallest) smallest = product
      if (product > largest) largest = product
    }
  }

  if (smallest === Infinity) {
    const empty: PalindromeResult = { value: null, factors: [] }
    return { smallest: empty, largest: empty }
  }
  return {
    smallest: { value: smallest, factors: factorsByProduct.get(smallest)! },
    largest: { value: largest, factors: factorsByProduct.get(largest)! },
  }
}
