//
// This is only a SKELETON file for the 'State of Tic Tac Toe' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const gamestate = (board) => {
  if (!Array.isArray(board) || board.length !== 3 || board.some(row => typeof row !== 'string' || row.length !== 3 || /[^XO ]/.test(row))) {
    throw new Error('Invalid board');
  }

  const cells = board.join('');
  const xCount = [...cells].filter(mark => mark === 'X').length;
  const oCount = [...cells].filter(mark => mark === 'O').length;
  if (oCount > xCount) throw new Error('Wrong turn order: O started');
  if (xCount > oCount + 1) throw new Error('Wrong turn order: X went twice');

  const lines = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8],
    [0, 3, 6], [1, 4, 7], [2, 5, 8],
    [0, 4, 8], [2, 4, 6],
  ];
  const hasWin = (position, mark) => lines.some(line => line.every(index => position[index] === mark));
  const xWon = hasWin(cells, 'X');
  const oWon = hasWin(cells, 'O');

  if (xWon || oWon) {
    const impossibleWinner = xWon && (oWon || xCount !== oCount + 1)
      || oWon && xCount !== oCount;
    const winner = xWon ? 'X' : 'O';
    const canBeLastMove = [...cells].some((mark, index) => {
      if (mark !== winner) return false;
      const previous = `${cells.slice(0, index)} ${cells.slice(index + 1)}`;
      return !hasWin(previous, winner);
    });
    if (impossibleWinner || !canBeLastMove) {
      throw new Error('Impossible board: game should have ended after the game was won');
    }
    return 'win';
  }

  return cells.includes(' ') ? 'ongoing' : 'draw';
};
