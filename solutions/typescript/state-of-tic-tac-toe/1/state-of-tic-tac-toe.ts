export const gamestate = (board: unknown): 'win' | 'draw' | 'ongoing' => {
  if (
    !Array.isArray(board) ||
    board.length !== 3 ||
    !board.every(
      (row) => typeof row === 'string' && row.length === 3 && /^[XO ]{3}$/.test(row)
    )
  ) {
    throw new Error('Invalid board')
  }

  const rows = board as string[]
  const squares = rows.join('')
  const xCount = [...squares].filter((mark) => mark === 'X').length
  const oCount = [...squares].filter((mark) => mark === 'O').length
  if (oCount > xCount) throw new Error('Wrong turn order: O started')
  if (xCount > oCount + 1) throw new Error('Wrong turn order: X went twice')

  const lines = [
    ...rows,
    ...[0, 1, 2].map((column) => rows.map((row) => row[column]).join('')),
    rows.map((row, index) => row[index]).join(''),
    rows.map((row, index) => row[2 - index]).join(''),
  ]
  const xWon = lines.includes('XXX')
  const oWon = lines.includes('OOO')

  if (
    (xWon && oWon) ||
    (xWon && xCount === oCount) ||
    (oWon && xCount > oCount)
  ) {
    throw new Error('Impossible board: game should have ended after the game was won')
  }
  if (xWon || oWon) return 'win'
  if (xCount + oCount === 9) return 'draw'
  return 'ongoing'
}
