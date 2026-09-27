//
// This is only a SKELETON file for the 'Conway's Game of Life' exercise. It's been provided
// as a convenience to get you started writing code faster.
//

export class GameOfLife {
  constructor(matrix) {
    this._state = matrix.map((row) => [...row]);
  }

  tick() {
    const rows = this._state.length;
    if (rows === 0) return;
    const columns = this._state[0].length;
    const next = Array.from({ length: rows }, () => Array(columns).fill(0));
    for (let r = 0; r < rows; r += 1) {
      for (let c = 0; c < columns; c += 1) {
        let neighbors = 0;
        for (let dr = -1; dr <= 1; dr += 1) {
          for (let dc = -1; dc <= 1; dc += 1) {
            if (dr !== 0 || dc !== 0) neighbors += this._state[r + dr]?.[c + dc] ?? 0;
          }
        }
        next[r][c] = neighbors === 3 || (this._state[r][c] === 1 && neighbors === 2) ? 1 : 0;
      }
    }
    this._state = next;
  }

  state() {
    return this._state.map((row) => [...row]);
  }
}
