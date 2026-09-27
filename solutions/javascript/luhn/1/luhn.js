export const valid = (input) => {
  if (!/^[0-9\s]+$/.test(input)) return false;
  const digits = input.replace(/\s/g, '');
  if (digits.length <= 1) return false;

  let sum = 0;
  let double = false;
  for (let index = digits.length - 1; index >= 0; index -= 1) {
    let digit = Number(digits[index]);
    if (double) {
      digit *= 2;
      if (digit > 9) digit -= 9;
    }
    sum += digit;
    double = !double;
  }
  return sum % 10 === 0;
};
