//
// This is only a SKELETON file for the 'Matching Brackets' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPaired = (input) => {
  const matching = { ')': '(', ']': '[', '}': '{' };
  const openings = new Set(Object.values(matching));
  const stack = [];
  for (const character of input) {
    if (openings.has(character)) stack.push(character);
    else if (Object.hasOwn(matching, character) && stack.pop() !== matching[character]) {
      return false;
    }
  }
  return stack.length === 0;
};
