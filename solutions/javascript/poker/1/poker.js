const rankValue = (rank) => ({ A: 14, K: 13, Q: 12, J: 11, 10: 10 })[rank] ?? Number(rank);

const evaluate = (hand) => {
  const cards = hand.split(' ').map((card) => ({
    rank: rankValue(card.slice(0, -1)),
    suit: card.slice(-1),
  }));
  const ranks = cards.map(({ rank }) => rank).sort((a, b) => b - a);
  const groups = [...new Set(ranks)]
    .map((rank) => ({ rank, count: ranks.filter((value) => value === rank).length }))
    .sort((a, b) => b.count - a.count || b.rank - a.rank);
  const flush = cards.every(({ suit }) => suit === cards[0].suit);
  const distinct = [...new Set(ranks)].sort((a, b) => a - b);
  const wheel = distinct.length === 5 && distinct.join(',') === '2,3,4,5,14';
  const straight = distinct.length === 5 && (wheel || distinct[4] - distinct[0] === 4);
  const straightHigh = wheel ? 5 : distinct[4];

  if (straight && flush) return [8, straightHigh];
  if (groups[0].count === 4) return [7, groups[0].rank, groups[1].rank];
  if (groups[0].count === 3 && groups[1].count === 2) {
    return [6, groups[0].rank, groups[1].rank];
  }
  if (flush) return [5, ...ranks];
  if (straight) return [4, straightHigh];
  if (groups[0].count === 3) {
    return [3, groups[0].rank, ...groups.slice(1).map(({ rank }) => rank).sort((a, b) => b - a)];
  }
  if (groups[0].count === 2 && groups[1].count === 2) {
    const pairs = groups.slice(0, 2).map(({ rank }) => rank).sort((a, b) => b - a);
    return [2, ...pairs, groups[2].rank];
  }
  if (groups[0].count === 2) {
    return [1, groups[0].rank, ...groups.slice(1).map(({ rank }) => rank).sort((a, b) => b - a)];
  }
  return [0, ...ranks];
};

const compareScores = (first, second) => {
  const length = Math.max(first.length, second.length);
  for (let i = 0; i < length; i += 1) {
    const difference = (first[i] || 0) - (second[i] || 0);
    if (difference !== 0) return difference;
  }
  return 0;
};

export const bestHands = (hands) => {
  let bestScore = null;
  const winners = [];
  for (const hand of hands) {
    const score = evaluate(hand);
    const comparison = bestScore === null ? 1 : compareScores(score, bestScore);
    if (comparison > 0) {
      bestScore = score;
      winners.length = 0;
      winners.push(hand);
    } else if (comparison === 0) {
      winners.push(hand);
    }
  }
  return winners;
};
