export const isValid = (isbn) => {
  const digits = isbn.replace(/-/g, '');
  if (digits.length !== 10) return false;
  if (!/^\d{9}[\dX]$/.test(digits)) return false;
  const check = digits[9] === 'X' ? 10 : parseInt(digits[9], 10);
  let sum = 0;
  for (let i = 0; i < 9; i++) {
    sum += parseInt(digits[i], 10) * (10 - i);
  }
  sum += check * 1;
  return sum % 11 === 0;
};
