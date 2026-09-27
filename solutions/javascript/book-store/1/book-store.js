//
// This is only a SKELETON file for the 'BookStore' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const cost = (books) => {
  const counts = Array(5).fill(0);
  for (const book of books) counts[book - 1] += 1;

  const discounts = [0, 0, 0.05, 0.1, 0.2, 0.25];
  const memo = new Map();
  const cheapest = (remaining) => {
    if (remaining.every((count) => count === 0)) return 0;
    const key = remaining.join(',');
    if (memo.has(key)) return memo.get(key);

    let minimum = Infinity;
    for (let mask = 1; mask < 1 << 5; mask += 1) {
      const next = [...remaining];
      let groupSize = 0;
      let valid = true;
      for (let index = 0; index < 5; index += 1) {
        if ((mask & (1 << index)) === 0) continue;
        if (next[index] === 0) {
          valid = false;
          break;
        }
        next[index] -= 1;
        groupSize += 1;
      }
      if (!valid) continue;

      const groupCost = groupSize * 800 * (1 - discounts[groupSize]);
      minimum = Math.min(minimum, groupCost + cheapest(next));
    }

    memo.set(key, minimum);
    return minimum;
  };

  return cheapest(counts);
};
