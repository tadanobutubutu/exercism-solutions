//
// This is only a SKELETON file for the 'Queen Attack' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class QueenAttack {
  constructor({
    black = [0, 3],
    white = [7, 3],
  } = {}) {
    const valid = ([row, column]) =>
      Number.isInteger(row) &&
      Number.isInteger(column) &&
      row >= 0 &&
      row < 8 &&
      column >= 0 &&
      column < 8;
    if (!valid(black) || !valid(white)) throw new Error('Queen must be placed on the board');
    if (black[0] === white[0] && black[1] === white[1]) {
      throw new Error('Queens cannot share the same space');
    }
    this.black = [...black];
    this.white = [...white];
  }

  toString() {
    return Array.from({ length: 8 }, (_, row) =>
      Array.from({ length: 8 }, (_, column) => {
        if (this.white[0] === row && this.white[1] === column) return 'W';
        if (this.black[0] === row && this.black[1] === column) return 'B';
        return '_';
      }).join(' '),
    ).join('\n');
  }

  get canAttack() {
    const rows = Math.abs(this.white[0] - this.black[0]);
    const columns = Math.abs(this.white[1] - this.black[1]);
    return rows === 0 || columns === 0 || rows === columns;
  }
}
