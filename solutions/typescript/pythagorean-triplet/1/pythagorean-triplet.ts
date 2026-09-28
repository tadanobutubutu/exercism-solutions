type Options = {
  minFactor?: number
  maxFactor?: number
  sum: number
}

export function triplets({ minFactor = 1, maxFactor = Infinity, sum }: Options): Triplet[] {
  if (!Number.isSafeInteger(sum) || sum < 3) return []
  const results: Triplet[] = []
  const firstPossibleA = Math.max(1, Math.ceil(minFactor))
  const lastPossibleA = Math.min(Math.floor((sum - 3) / 3), Math.floor((sum - 1) / 3))

  for (let a = firstPossibleA; a <= lastPossibleA; a++) {
    const numerator = sum * (sum - 2 * a)
    const denominator = 2 * (sum - a)
    if (numerator % denominator !== 0) continue
    const b = numerator / denominator
    const c = sum - a - b
    if (
      a < b &&
      b < c &&
      c <= maxFactor &&
      a <= maxFactor &&
      b <= maxFactor
    ) {
      results.push(new Triplet(a, b, c))
    }
  }
  return results
}

class Triplet {
  constructor(
    private readonly a: number,
    private readonly b: number,
    private readonly c: number
  ) {}

  toArray(): [number, number, number] {
    return [this.a, this.b, this.c]
  }
}
