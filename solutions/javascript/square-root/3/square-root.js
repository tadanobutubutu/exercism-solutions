//
// This is only a SKELETON file for the 'Square root' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const squareRoot = (number) => {
  if (number < 2) return number;
  let low = 1;
  let high = number;
  while (low <= high) {
    const middle = Math.floor((low + high) / 2);
    const square = middle * middle;
    if (square === number) return middle;
    if (square < number) low = middle + 1;
    else high = middle - 1;
  }
  return high;
};
