export const prime = (n) => {
  if (n === 0) throw new Error('there is no zeroth prime');
  const primes = [];
  let i = 2;
  while (primes.length < n) {
    let isPrime = true;
    for (const p of primes) {
      if (p * p > i) break;
      if (i % p === 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) primes.push(i);
    i++;
  }
  return primes[primes.length - 1];
};
