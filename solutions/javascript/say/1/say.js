//
// This is only a SKELETON file for the 'Say' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const say = (n) => {
  if (!Number.isInteger(n) || n < 0 || n > 999_999_999_999) {
    throw new Error('Number must be between 0 and 999,999,999,999.');
  }

  const small = [
    'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine',
    'ten', 'eleven', 'twelve', 'thirteen', 'fourteen', 'fifteen', 'sixteen',
    'seventeen', 'eighteen', 'nineteen',
  ];
  const tens = ['', '', 'twenty', 'thirty', 'forty', 'fifty', 'sixty', 'seventy', 'eighty', 'ninety'];

  const underThousand = value => {
    const words = [];
    const hundreds = Math.floor(value / 100);
    const remainder = value % 100;
    if (hundreds > 0) words.push(`${small[hundreds]} hundred`);
    if (remainder >= 20) {
      const units = remainder % 10;
      words.push(units ? `${tens[Math.floor(remainder / 10)]}-${small[units]}` : tens[Math.floor(remainder / 10)]);
    } else if (remainder > 0) {
      words.push(small[remainder]);
    }
    return words.join(' ');
  };

  if (n === 0) return 'zero';
  const scales = ['', 'thousand', 'million', 'billion'];
  const groups = [];
  let value = n;
  for (const scale of scales) {
    const group = value % 1000;
    if (group > 0) {
      const words = underThousand(group);
      groups.unshift(scale ? `${words} ${scale}` : words);
    }
    value = Math.floor(value / 1000);
  }
  return groups.join(' ');
};
