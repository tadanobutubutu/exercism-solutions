export const squareRoot = (n) => {
  if (n === 0 || n === 1) return n;
  let x = n;
  let y = (x + 1) / 2;
  while (y < x) {
    x = y;
    y = (x + n / x) / 2;
  }
  return x;
};
