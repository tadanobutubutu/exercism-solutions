//
// This is only a SKELETON file for the 'Sum Of Multiples' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const sum = (factors, limit) => {
  const multiples = new Set();
  for (const factor of factors) {
    if (!Number.isInteger(factor) || factor <= 0) continue;
    for (let value = factor; value < limit; value += factor) multiples.add(value);
  }
  let total = 0;
  for (const value of multiples) total += value;
  return total;
};
