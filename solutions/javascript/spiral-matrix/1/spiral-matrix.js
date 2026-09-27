//
// This is only a SKELETON file for the 'Spiral Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const spiralMatrix = (size) => {
  if (size === 0) return [];
  const matrix = Array.from({ length: size }, () => Array(size).fill(0));
  let top = 0;
  let bottom = size - 1;
  let left = 0;
  let right = size - 1;
  let value = 1;
  while (top <= bottom && left <= right) {
    for (let column = left; column <= right; column += 1) matrix[top][column] = value++;
    top += 1;
    for (let row = top; row <= bottom; row += 1) matrix[row][right] = value++;
    right -= 1;
    if (top <= bottom) {
      for (let column = right; column >= left; column -= 1) matrix[bottom][column] = value++;
      bottom -= 1;
    }
    if (left <= right) {
      for (let row = bottom; row >= top; row -= 1) matrix[row][left] = value++;
      left += 1;
    }
  }
  return matrix;
};
