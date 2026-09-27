export const classify = (number) => {
  if (!Number.isInteger(number) || number < 1) {
    throw new Error('Classification is only possible for natural numbers.');
  }

  let sum = 0;
  for (let divisor = 1; divisor * divisor <= number; divisor += 1) {
    if (number % divisor !== 0) continue;
    const paired = number / divisor;
    if (divisor < number) sum += divisor;
    if (paired !== divisor && paired < number) sum += paired;
  }

  if (sum === number) return 'perfect';
  return sum > number ? 'abundant' : 'deficient';
};
