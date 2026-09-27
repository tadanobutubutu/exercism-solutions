//
// This is only a SKELETON file for the 'Knapsack' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const knapsack = (maximumWeight, items) => {
  const bestValueAtWeight = Array(maximumWeight + 1).fill(0);
  for (const { weight, value } of items) {
    for (let capacity = maximumWeight; capacity >= weight; capacity -= 1) {
      bestValueAtWeight[capacity] = Math.max(
        bestValueAtWeight[capacity],
        bestValueAtWeight[capacity - weight] + value,
      );
    }
  }
  return bestValueAtWeight[maximumWeight];
};
