const digitsToNumber = (digits, base) => {
  let num = 0;
  for (const d of digits) {
    num = num * base + d;
  }
  return num;
};

const numberToDigits = (num, base) => {
  if (num === 0) return [0];
  const digits = [];
  while (num > 0) {
    digits.unshift(num % base);
    num = Math.floor(num / base);
  }
  return digits;
};

export const convert = (digits, inputBase, outputBase) => {
  if (inputBase < 2) throw new Error('Wrong input base');
  if (outputBase < 2) throw new Error('Wrong output base');
  if (digits.length === 0) throw new Error('Input has wrong format');
  if (digits.length > 1 && digits[0] === 0) throw new Error('Input has wrong format');
  for (const d of digits) {
    if (d < 0 || d >= inputBase) throw new Error('Input has wrong format');
  }
  const num = digitsToNumber(digits, inputBase);
  return numberToDigits(num, outputBase);
};
