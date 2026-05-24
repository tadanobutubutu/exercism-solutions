export const saddlePoints = (matrix) => {
  if (matrix.length === 0 || matrix[0].length === 0) return [];
  const rowMax = matrix.map((row) => Math.max(...row));
  const colMin = matrix[0].map((_, c) =>
    Math.min(...matrix.map((row) => row[c])),
  );
  const result = [];
  for (let r = 0; r < matrix.length; r++) {
    for (let c = 0; c < matrix[r].length; c++) {
      if (matrix[r][c] === rowMax[r] && matrix[r][c] === colMin[c]) {
        result.push({ row: r + 1, column: c + 1 });
      }
    }
  }
  return result;
};
