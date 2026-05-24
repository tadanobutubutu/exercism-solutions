//
// This is only a SKELETON file for the 'Armstrong Numbers' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isArmstrongNumber = (num) => {
  const digits = String(num).split('').map(Number);
  const power = digits.length;
  const sum = digits.reduce((acc, d) => acc + BigInt(d) ** BigInt(power), 0n);
  return sum === BigInt(num);
};
