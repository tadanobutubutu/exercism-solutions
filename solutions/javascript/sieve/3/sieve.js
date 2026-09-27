//
// This is only a SKELETON file for the 'Sieve' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const primes = (limit) => {
  if (limit < 2) return [];
  const isPrime = Array(limit + 1).fill(true);
  isPrime[0] = false;
  isPrime[1] = false;
  for (let value = 2; value * value <= limit; value += 1) {
    if (!isPrime[value]) continue;
    for (let multiple = value * value; multiple <= limit; multiple += value) {
      isPrime[multiple] = false;
    }
  }
  return isPrime.flatMap((prime, value) => (prime ? [value] : []));
};
