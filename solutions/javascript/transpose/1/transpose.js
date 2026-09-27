//
// This is only a SKELETON file for the 'Transpose' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const transpose = (input) => {
  const maxWidth = input.reduce((width, row) => Math.max(width, row.length), 0);
  const result = [];
  for (let column = 0; column < maxWidth; column += 1) {
    let transposed = '';
    let lastRowWithCharacter = -1;
    for (let rowIndex = 0; rowIndex < input.length; rowIndex += 1) {
      if (column < input[rowIndex].length) lastRowWithCharacter = rowIndex;
    }
    for (let rowIndex = 0; rowIndex <= lastRowWithCharacter; rowIndex += 1) {
      transposed += input[rowIndex][column] ?? ' ';
    }
    result.push(transposed);
  }
  return result;
};
