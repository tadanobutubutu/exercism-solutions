//
// This is only a SKELETON file for the 'Saddle Points' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const saddlePoints = (matrix) => {
  if (matrix.length === 0 || matrix[0].length === 0) return [];
  const columnMinimums = Array.from({ length: matrix[0].length }, (_, column) =>
    Math.min(...matrix.map((row) => row[column])),
  );
  const points = [];
  matrix.forEach((row, r) => {
    const rowMaximum = Math.max(...row);
    row.forEach((value, c) => {
      if (value === rowMaximum && value === columnMinimums[c]) {
        points.push({ row: r + 1, column: c + 1 });
      }
    });
  });
  return points;
};
