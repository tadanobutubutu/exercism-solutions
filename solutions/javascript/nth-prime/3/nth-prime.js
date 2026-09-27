//
// This is only a SKELETON file for the 'Nth Prime' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const prime = (n) => {
  if (n < 1) throw new Error('there is no zeroth prime');
  const found = [];
  for (let candidate = 2; found.length < n; candidate += 1) {
    let isPrime = true;
    for (const divisor of found) {
      if (divisor * divisor > candidate) break;
      if (candidate % divisor === 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) found.push(candidate);
  }
  return found[n - 1];
};
