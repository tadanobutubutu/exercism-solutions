const SIZE = 8;

const validate = (row, col) => {
  if (row < 0 || row >= SIZE || col < 0 || col >= SIZE) {
    throw new Error('Queen must be placed on the board');
  }
};

export class QueenAttack {
  constructor({
    black: [blackRow, blackColumn] = [0, 3],
    white: [whiteRow, whiteColumn] = [7, 3],
  } = {}) {
    validate(whiteRow, whiteColumn);
    validate(blackRow, blackColumn);
    if (whiteRow === blackRow && whiteColumn === blackColumn) {
      throw new Error('Queens cannot share the same space');
    }
    this._white = [whiteRow, whiteColumn];
    this._black = [blackRow, blackColumn];
  }

  get white() {
    return this._white;
  }

  get black() {
    return this._black;
  }

  get canAttack() {
    const [wr, wc] = this._white;
    const [br, bc] = this._black;
    return wr === br || wc === bc || Math.abs(wr - br) === Math.abs(wc - bc);
  }

  toString() {
    const board = Array.from({ length: SIZE }, () => new Array(SIZE).fill('_'));
    const [wr, wc] = this._white;
    const [br, bc] = this._black;
    board[wr][wc] = 'W';
    board[br][bc] = 'B';
    return board.map((row) => row.join(' ')).join('\n');
  }
}
