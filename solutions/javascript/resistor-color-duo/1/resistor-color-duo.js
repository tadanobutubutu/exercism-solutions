//
// This is only a SKELETON file for the 'Resistor Color Duo' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const colors = [
  'black', 'brown', 'red', 'orange', 'yellow',
  'green', 'blue', 'violet', 'grey', 'white',
];

export const decodedValue = (inputColors) => {
  return Number(inputColors.slice(0, 2).map((color) => colors.indexOf(color)).join(''));
};
