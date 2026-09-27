//
// This is only a SKELETON file for the 'Change' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Change {
  calculate(coinArray, target) {
    if (target < 0) throw new Error('Negative totals are not allowed.');
    if (target === 0) return [];

    const coins = [...new Set(coinArray.filter((coin) => Number.isInteger(coin) && coin > 0))];
    const best = Array(target + 1).fill(Infinity);
    const previous = Array(target + 1).fill(null);
    best[0] = 0;

    for (let amount = 1; amount <= target; amount += 1) {
      for (const coin of coins) {
        if (coin <= amount && best[amount - coin] + 1 < best[amount]) {
          best[amount] = best[amount - coin] + 1;
          previous[amount] = coin;
        }
      }
    }
    if (!Number.isFinite(best[target])) {
      throw new Error(`The total ${target} cannot be represented in the given currency.`);
    }
    const result = [];
    for (let amount = target; amount > 0; amount -= previous[amount]) {
      result.push(previous[amount]);
    }
    return result.sort((a, b) => a - b);
  }
}
