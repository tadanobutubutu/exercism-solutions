//
// This is only a SKELETON file for the 'Dominoes' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const chain = dominoes => {
  if (dominoes.length === 0) return [];

  const start = dominoes[0][0];
  const used = Array(dominoes.length).fill(false);
  const path = [];

  const search = (current, count) => {
    if (count === dominoes.length) return current === start ? [...path] : null;

    for (let index = 0; index < dominoes.length; index += 1) {
      if (used[index]) continue;
      const [left, right] = dominoes[index];
      const orientations = left === right
        ? [[left, right]]
        : [[left, right], [right, left]];

      for (const [first, second] of orientations) {
        if (first !== current) continue;
        used[index] = true;
        path.push([first, second]);
        const result = search(second, count + 1);
        if (result !== null) return result;
        path.pop();
        used[index] = false;
      }
    }

    return null;
  };

  return search(start, 0);
};
