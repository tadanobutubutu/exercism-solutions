type GameResult = { status: 'finished' | 'loop'; cards: number; tricks: number }

const payment = new Map<string, number>([
  ['J', 1],
  ['Q', 2],
  ['K', 3],
  ['A', 4],
])

export const simulateGame = (playerA: unknown, playerB: unknown): GameResult => {
  if (!Array.isArray(playerA) || !Array.isArray(playerB)) {
    throw new Error('Invalid decks')
  }
  const decks: [string[], string[]] = [playerA, playerB]
  if (decks.some((deck) => deck.some((card) => typeof card !== 'string'))) {
    throw new Error('Invalid card')
  }

  let player = 0
  let penalty = 0
  let lastPaymentPlayer = 0
  let cards = 0
  let tricks = 0
  const totalCards = decks[0].length + decks[1].length
  let pile: string[] = []
  const seen = new Set<string>()

  const state = (): string =>
    decks
      .map((deck) => `${deck.length}:${deck.filter((card) => payment.has(card)).join('')}`)
      .join('|') + `|${player}`

  while (true) {
    if (penalty === 0 && pile.length === 0) {
      const snapshot = state()
      if (cards > 0 && seen.has(snapshot)) return { status: 'loop', cards, tricks }
      seen.add(snapshot)
    }

    if (decks[player].length === 0) {
      const winner = penalty > 0 ? lastPaymentPlayer : 1 - player
      decks[winner].push(...pile)
      pile = []
      tricks++
      if (decks[winner].length === totalCards) return { status: 'finished', cards, tricks }
      player = winner
      penalty = 0
      continue
    }

    const card = decks[player].shift()!
    pile.push(card)
    cards++

    const newPenalty = payment.get(card)
    if (newPenalty !== undefined) {
      penalty = newPenalty
      lastPaymentPlayer = player
      player = 1 - player
    } else if (penalty > 0) {
      penalty--
      if (penalty === 0) {
        decks[lastPaymentPlayer].push(...pile)
        pile = []
        tricks++
        if (decks[lastPaymentPlayer].length === totalCards) {
          return { status: 'finished', cards, tricks }
        }
        player = lastPaymentPlayer
      }
    } else {
      player = 1 - player
    }
  }
}
