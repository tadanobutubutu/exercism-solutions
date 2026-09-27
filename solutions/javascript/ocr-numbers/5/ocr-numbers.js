//
// This is only a SKELETON file for the 'OCR Numbers' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const DIGITS = [
  ' _ \n| |\n|_|\n   ',
  '   \n  |\n  |\n   ',
  ' _ \n _|\n|_ \n   ',
  ' _ \n _|\n _|\n   ',
  '   \n|_|\n  |\n   ',
  ' _ \n|_ \n _|\n   ',
  ' _ \n|_ \n|_|\n   ',
  ' _ \n  |\n  |\n   ',
  ' _ \n|_|\n|_|\n   ',
  ' _ \n|_|\n _|\n   ',
];
const DIGIT_MAP = new Map(DIGITS.map((pattern, digit) => [pattern, String(digit)]));

export const convert = (input) => {
  const rows = input.split('\n');
  if (rows.length % 4 !== 0) throw new Error('number of input lines is not a multiple of four');
  const width = rows[0]?.length ?? 0;
  if (width % 3 !== 0 || rows.some((row) => row.length !== width)) {
    throw new Error('input is not a multiple of three');
  }
  const output = [];
  for (let offset = 0; offset < rows.length; offset += 4) {
    let number = '';
    for (let col = 0; col < width; col += 3) {
      const pattern = rows.slice(offset, offset + 4).map((row) => row.slice(col, col + 3)).join('\n');
      number += DIGIT_MAP.get(pattern) ?? '?';
    }
    output.push(number);
  }
  return output.join(',');
};
