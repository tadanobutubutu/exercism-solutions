//
// This is only a SKELETON file for the 'Largest Series Product' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const largestProduct = (digits, span) => {
  if (span < 0) throw new Error('span must not be negative');
  if (span > digits.length) throw new Error('span must not exceed string length');
  if (/\D/.test(digits)) throw new Error('digits input must only contain digits');
  if (span === 0) return 1;

  let largest = 0;
  for (let start = 0; start <= digits.length - span; start += 1) {
    let product = 1;
    for (let index = start; index < start + span; index += 1) {
      product *= Number(digits[index]);
    }
    largest = Math.max(largest, product);
  }
  return largest;
};
