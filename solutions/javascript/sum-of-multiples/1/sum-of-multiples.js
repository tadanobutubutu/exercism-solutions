export const sum = (factors, limit) => {
  const multiples = new Set();
  for (const factor of factors) {
    if (factor === 0) continue;
    for (let i = factor; i < limit; i += factor) {
      multiples.add(i);
    }
  }
  return [...multiples].reduce((acc, n) => acc + n, 0);
};
