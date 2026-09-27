//
// This is only a SKELETON file for the 'Rectangles' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export function count(rows) {
  let rectangles = 0;
  const horizontalEdge = (row, left, right) => {
    if (row[left] !== '+' || row[right] !== '+') return false;
    for (let column = left + 1; column < right; column += 1) {
      if (row[column] !== '-' && row[column] !== '+') return false;
    }
    return true;
  };
  const verticalEdge = (top, bottom, column) => {
    if (rows[top][column] !== '+' || rows[bottom][column] !== '+') return false;
    for (let row = top + 1; row < bottom; row += 1) {
      if (rows[row][column] !== '|' && rows[row][column] !== '+') return false;
    }
    return true;
  };

  for (let top = 0; top < rows.length; top += 1) {
    for (let left = 0; left < rows[top].length; left += 1) {
      if (rows[top][left] !== '+') continue;
      for (let right = left + 1; right < rows[top].length; right += 1) {
        if (!horizontalEdge(rows[top], left, right)) continue;
        for (let bottom = top + 1; bottom < rows.length; bottom += 1) {
          if (
            horizontalEdge(rows[bottom], left, right) &&
            verticalEdge(top, bottom, left) &&
            verticalEdge(top, bottom, right)
          ) {
            rectangles += 1;
          }
        }
      }
    }
  }
  return rectangles;
}
