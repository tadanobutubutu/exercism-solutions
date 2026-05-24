export function count(rows) {
  let result = 0;
  const corners = [];
  for (let r = 0; r < rows.length; r++) {
    for (let c = 0; c < rows[r].length; c++) {
      if (rows[r][c] === '+') {
        corners.push([r, c]);
      }
    }
  }
  for (let i = 0; i < corners.length; i++) {
    for (let j = i + 1; j < corners.length; j++) {
      const [r1, c1] = corners[i];
      const [r2, c2] = corners[j];
      if (r1 < r2 && c1 < c2) {
        if (rows[r1][c2] !== '+' || rows[r2][c1] !== '+') continue;
        let valid = true;
        for (let c = c1 + 1; c < c2; c++) {
          if (rows[r1][c] !== '-' && rows[r1][c] !== '+') {
            valid = false;
            break;
          }
        }
        if (!valid) continue;
        for (let c = c1 + 1; c < c2; c++) {
          if (rows[r2][c] !== '-' && rows[r2][c] !== '+') {
            valid = false;
            break;
          }
        }
        if (!valid) continue;
        for (let r = r1 + 1; r < r2; r++) {
          if (rows[r][c1] !== '|' && rows[r][c1] !== '+') {
            valid = false;
            break;
          }
        }
        if (!valid) continue;
        for (let r = r1 + 1; r < r2; r++) {
          if (rows[r][c2] !== '|' && rows[r][c2] !== '+') {
            valid = false;
            break;
          }
        }
        if (valid) result++;
      }
    }
  }
  return result;
}
