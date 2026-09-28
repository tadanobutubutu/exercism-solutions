export const findFewestCoins = (coins: unknown, target: unknown): unknown => {
  if (typeof target !== 'number' || !Number.isInteger(target)) {
    throw new Error("can't make target with given coins")
  }
  if (target < 0) throw new Error("target can't be negative")
  if (target === 0) return []
  if (!Array.isArray(coins)) throw new Error("can't make target with given coins")

  const usableCoins = [...new Set(coins.filter(
    (coin): coin is number => typeof coin === 'number' && Number.isInteger(coin) && coin > 0
  ))].sort((a, b) => a - b)
  const best: (number[] | undefined)[] = Array(target + 1)
  best[0] = []

  for (let amount = 1; amount <= target; amount++) {
    for (const coin of usableCoins) {
      if (coin > amount) break
      const previous = best[amount - coin]
      if (!previous) continue

      const candidate = [...previous, coin].sort((a, b) => a - b)
      if (
        !best[amount] ||
        candidate.length < best[amount]!.length ||
        (candidate.length === best[amount]!.length &&
          candidate.join(',') < best[amount]!.join(','))
      ) {
        best[amount] = candidate
      }
    }
  }

  if (!best[target]) throw new Error("can't make target with given coins")
  return best[target]
}
