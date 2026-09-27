export class Board {
  constructor(rows) {
    this.grid = rows.map((row) => row.trim().split(/\s+/));
  }

  winner() {
    if (this.grid.length === 0 || this.grid[0].length === 0) return '';

    const hasConnection = (player, starts, isGoal) => {
      const queue = [...starts];
      const visited = new Set();
      const directions = [
        [0, -1], [0, 1],
        [-1, 0], [-1, 1],
        [1, 0], [1, -1],
      ];

      for (let head = 0; head < queue.length; head += 1) {
        const [row, column] = queue[head];
        const key = `${row},${column}`;
        if (visited.has(key) || this.grid[row]?.[column] !== player) continue;
        visited.add(key);
        if (isGoal(row, column)) return true;

        for (const [rowStep, columnStep] of directions) {
          const nextRow = row + rowStep;
          const nextColumn = column + columnStep;
          if (this.grid[nextRow]?.[nextColumn] === player) {
            queue.push([nextRow, nextColumn]);
          }
        }
      }
      return false;
    };

    const xStarts = this.grid.map((row, index) => [index, 0]);
    if (hasConnection('X', xStarts, (_row, column) => column === this.grid[0].length - 1)) {
      return 'X';
    }

    const oStarts = this.grid[0].map((_, column) => [0, column]);
    if (hasConnection('O', oStarts, (row) => row === this.grid.length - 1)) return 'O';
    return '';
  }
}
