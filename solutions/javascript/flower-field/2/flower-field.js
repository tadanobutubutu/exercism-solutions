//
// This is only a SKELETON file for the 'Flower Field' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const annotate = (input) => {
  if (input.length === 0) return [];
  if (input.every((row) => row.length === 0)) return input.map(() => '');
  return input.map((row, r) =>
    [...row]
      .map((cell, c) => {
        if (cell === '*') return '*';
        let count = 0;
        for (let dr = -1; dr <= 1; dr += 1) {
          for (let dc = -1; dc <= 1; dc += 1) {
            if (dr !== 0 || dc !== 0) count += input[r + dr]?.[c + dc] === '*' ? 1 : 0;
          }
        }
        return count === 0 ? ' ' : String(count);
      })
      .join(''),
  );
};
