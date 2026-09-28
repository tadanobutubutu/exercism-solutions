type ScoredHand = { hand: string; score: number[] }

const rankValue = (rank: string): number => {
  if (rank === 'A') return 14
  if (rank === 'K') return 13
  if (rank === 'Q') return 12
  if (rank === 'J') return 11
  return Number(rank)
}

const scoreHand = (hand: string): number[] => {
  const cards = hand.split(' ').map((card) => {
    const rank = card.startsWith('10') ? '10' : card[0]!
    return { rank: rankValue(rank), suit: card[card.length - 1]! }
  })
  const ranks = cards.map((card) => card.rank).sort((a, b) => b - a)
  const counts = new Map<number, number>()
  for (const rank of ranks) counts.set(rank, (counts.get(rank) ?? 0) + 1)
  const groups = [...counts.entries()].sort((a, b) => b[1] - a[1] || b[0] - a[0])
  const flush = cards.every((card) => card.suit === cards[0]?.suit)
  const unique = [...new Set(ranks)].sort((a, b) => a - b)
  let straightHigh = 0
  if (unique.length === 5) {
    if (unique[4]! - unique[0]! === 4) straightHigh = unique[4]!
    else if (unique.join(',') === '2,3,4,5,14') straightHigh = 5
  }
  const straight = straightHigh > 0

  if (straight && flush) return [8, straightHigh]
  if (groups[0]?.[1] === 4) return [7, groups[0][0], groups[1]![0]]
  if (groups[0]?.[1] === 3 && groups[1]?.[1] === 2) {
    return [6, groups[0][0], groups[1][0]]
  }
  if (flush) return [5, ...ranks]
  if (straight) return [4, straightHigh]
  if (groups[0]?.[1] === 3) {
    return [3, groups[0][0], ...groups.slice(1).map(([rank]) => rank).sort((a, b) => b - a)]
  }
  const pairs = groups.filter(([, count]) => count === 2).map(([rank]) => rank).sort((a, b) => b - a)
  if (pairs.length === 2) {
    const kicker = groups.find(([, count]) => count === 1)?.[0] ?? 0
    return [2, pairs[0]!, pairs[1]!, kicker]
  }
  if (pairs.length === 1) {
    const kickers = groups.filter(([, count]) => count === 1).map(([rank]) => rank).sort((a, b) => b - a)
    return [1, pairs[0]!, ...kickers]
  }
  return [0, ...ranks]
}

const compareScores = (first: number[], second: number[]): number => {
  for (let index = 0; index < Math.max(first.length, second.length); index++) {
    const difference = (first[index] ?? 0) - (second[index] ?? 0)
    if (difference !== 0) return difference
  }
  return 0
}

export function bestHands(hands: string[]): string[] {
  const scored: ScoredHand[] = hands.map((hand) => ({ hand, score: scoreHand(hand) }))
  if (scored.length === 0) return []
  let best = scored[0]!.score
  for (const item of scored.slice(1)) {
    if (compareScores(item.score, best) > 0) best = item.score
  }
  return scored.filter(({ score }) => compareScores(score, best) === 0).map(({ hand }) => hand)
}
