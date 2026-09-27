//
// This is only a SKELETON file for the 'Pascals Triangle' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const rows = (count) => {
  const result = [];
  for (let rowIndex = 0; rowIndex < count; rowIndex += 1) {
    const previous = result[rowIndex - 1] ?? [];
    const row = Array.from({ length: rowIndex + 1 }, (_, column) => {
      if (column === 0 || column === rowIndex) return 1;
      return previous[column - 1] + previous[column];
    });
    result.push(row);
  }
  return result;
};
