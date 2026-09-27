export const combinations = ({ sum, size, exclude = [] }) => {
  if (!Number.isInteger(size) || size < 1 || size > 9 || !Number.isInteger(sum)) return [];
  const unavailable = new Set(exclude);
  const digits = Array.from({ length: 9 }, (_, index) => index + 1)
    .filter((digit) => !unavailable.has(digit));
  if (digits.length < size) return [];

  const results = [];
  const choose = (start, remaining, target, current) => {
    if (remaining === 0) {
      if (target === 0) results.push([...current]);
      return;
    }
    if (digits.length - start < remaining) return;

    const smallest = digits.slice(start, start + remaining)
      .reduce((total, digit) => total + digit, 0);
    const largest = digits.slice(-remaining)
      .reduce((total, digit) => total + digit, 0);
    if (target < smallest || target > largest) return;

    for (let index = start; index <= digits.length - remaining; index += 1) {
      const digit = digits[index];
      if (digit > target) break;
      current.push(digit);
      choose(index + 1, remaining - 1, target - digit, current);
      current.pop();
    }
  };

  choose(0, size, sum, []);
  return results;
};
