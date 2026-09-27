export const score = (dice, category) => {
  const counts = Array(7).fill(0);
  for (const die of dice) counts[die] += 1;
  const sum = dice.reduce((total, die) => total + die, 0);

  if (category === 'yacht') return counts.some((count) => count === 5) ? 50 : 0;
  if (['ones', 'twos', 'threes', 'fours', 'fives', 'sixes'].includes(category)) {
    const face = ['ones', 'twos', 'threes', 'fours', 'fives', 'sixes'].indexOf(category) + 1;
    return face * counts[face];
  }
  if (category === 'full house') {
    return counts.includes(2) && counts.includes(3) ? sum : 0;
  }
  if (category === 'four of a kind') {
    const face = counts.findIndex((count) => count >= 4);
    return face < 0 ? 0 : face * 4;
  }
  if (category === 'little straight') {
    return [1, 2, 3, 4, 5].every((face) => counts[face] === 1) ? 30 : 0;
  }
  if (category === 'big straight') {
    return [2, 3, 4, 5, 6].every((face) => counts[face] === 1) ? 30 : 0;
  }
  if (category === 'choice') return sum;
  return 0;
};
