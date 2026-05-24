export const annotate = (input) => {
  const rows = input.length;
  if (rows === 0) return [];
  const cols = input[0].length;
  const result = input.map((row) => row.split(''));

  for (let r = 0; r < rows; r++) {
    for (let c = 0; c < cols; c++) {
      if (result[r][c] === '*') continue;
      let count = 0;
      for (let dr = -1; dr <= 1; dr++) {
        for (let dc = -1; dc <= 1; dc++) {
          if (dr === 0 && dc === 0) continue;
          const nr = r + dr;
          const nc = c + dc;
          if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && input[nr][nc] === '*') {
            count++;
          }
        }
      }
      result[r][c] = count === 0 ? ' ' : String(count);
    }
  }

  return result.map((row) => row.join(''));
};
