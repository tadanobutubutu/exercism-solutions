export class Change {
  calculate(coinArray, target) {
    if (target < 0) throw new Error('Negative totals are not allowed.');
    if (target === 0) return [];
    const sorted = [...coinArray].filter(c => c > 0).sort((a, b) => a - b);
    const dp = new Array(target + 1).fill(null);
    dp[0] = [];
    for (let i = 1; i <= target; i++) {
      let best = null;
      for (const coin of sorted) {
        if (coin > i) break;
        const prev = dp[i - coin];
        if (prev !== null) {
          const candidate = [...prev, coin];
          if (best === null || candidate.length < best.length) {
            best = candidate;
          } else if (candidate.length === best.length) {
            const sumDiff = coin - best[best.length - 1];
            if (sumDiff > 0) {
              let useCandidate = false;
              for (let k = best.length - 1; k >= 0; k--) {
                if (candidate[k] !== best[k]) {
                  if (candidate[k] < best[k]) useCandidate = true;
                  break;
                }
              }
              if (useCandidate) best = candidate;
            }
          }
        }
      }
      dp[i] = best;
    }
    if (dp[target] === null) {
      throw new Error(`The total ${target} cannot be represented in the given currency.`);
    }
    return dp[target].sort((a, b) => a - b);
  }
}
