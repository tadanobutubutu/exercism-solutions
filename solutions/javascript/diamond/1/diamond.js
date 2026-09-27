//
// This is only a SKELETON file for the 'Diamond' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const rows = (letter) => {
  const height = letter.charCodeAt(0) - 64;
  const width = height * 2 - 1;
  const top = [];
  for (let index = 0; index < height; index += 1) {
    const character = String.fromCharCode(65 + index);
    const outer = height - index - 1;
    const inner = index === 0 ? 0 : index * 2 - 1;
    top.push(' '.repeat(outer) + character + ' '.repeat(inner) + (index === 0 ? '' : character) + ' '.repeat(outer));
  }
  return [...top, ...top.slice(0, -1).reverse()];
};
