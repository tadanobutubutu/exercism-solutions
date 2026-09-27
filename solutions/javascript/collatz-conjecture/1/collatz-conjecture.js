export const steps = (value) => {
  if (!Number.isInteger(value) || value <= 0) {
    throw new Error('Only positive integers are allowed');
  }

  let count = 0;
  while (value !== 1) {
    value = value % 2 === 0 ? value / 2 : 3 * value + 1;
    count += 1;
  }
  return count;
};
