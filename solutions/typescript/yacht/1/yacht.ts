//
// This is only a SKELETON file for the 'Yacht' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const enum Category {
  ONES,
  TWOS,
  THREES,
  FOURS,
  FIVES,
  SIXES,
  FULL_HOUSE,
  FOUR_OF_A_KIND,
  LITTLE_STRAIGHT,
  BIG_STRAIGHT,
  CHOICE,
  YACHT,
}

export const score = (dice: unknown, category: Category): number => {
  const rolls = dice as number[]
  const sum = rolls.reduce((total, die) => total + die, 0)
  const counts = new Map<number, number>()
  for (const die of rolls) counts.set(die, (counts.get(die) ?? 0) + 1)

  if (category >= Category.ONES && category <= Category.SIXES) {
    const face = category + 1
    return face * (counts.get(face) ?? 0)
  }

  switch (category) {
    case Category.FULL_HOUSE:
      return counts.size === 2 && [...counts.values()].sort().join(',') === '2,3' ? sum : 0
    case Category.FOUR_OF_A_KIND: {
      const fourOfAKind = [...counts].find(([, count]) => count >= 4)
      return fourOfAKind === undefined ? 0 : fourOfAKind[0] * 4
    }
    case Category.LITTLE_STRAIGHT:
      return [1, 2, 3, 4, 5].every((face) => counts.has(face)) ? 30 : 0
    case Category.BIG_STRAIGHT:
      return [2, 3, 4, 5, 6].every((face) => counts.has(face)) ? 30 : 0
    case Category.CHOICE:
      return sum
    case Category.YACHT:
      return counts.size === 1 ? 50 : 0
    default:
      return 0
  }
}
