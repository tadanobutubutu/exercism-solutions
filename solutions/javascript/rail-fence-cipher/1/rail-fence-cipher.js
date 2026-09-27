//
// This is only a SKELETON file for the 'Rail Fence Cipher' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const railForPosition = (position, rails) => {
  if (rails <= 1) return 0;
  const cycle = 2 * (rails - 1);
  const offset = position % cycle;
  return offset < rails ? offset : cycle - offset;
};

export const encode = (text, rails) => {
  const characters = [...text];
  if (rails <= 1 || characters.length <= 1) return text;
  const rows = Array.from({ length: rails }, () => []);
  characters.forEach((character, index) => rows[railForPosition(index, rails)].push(character));
  return rows.flat().join('');
};

export const decode = (text, rails) => {
  const characters = [...text];
  if (rails <= 1 || characters.length <= 1) return text;
  const rowCounts = Array(rails).fill(0);
  characters.forEach((_, index) => { rowCounts[railForPosition(index, rails)] += 1; });
  const rows = [];
  let cursor = 0;
  for (const count of rowCounts) {
    rows.push(characters.slice(cursor, cursor + count));
    cursor += count;
  }
  const offsets = Array(rails).fill(0);
  return characters.map((_, index) => {
    const row = railForPosition(index, rails);
    return rows[row][offsets[row]++];
  }).join('');
};
