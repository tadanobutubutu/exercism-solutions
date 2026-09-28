type Cell = [row: number, column: number]

export class Board {
  private readonly cells: string[][]

  constructor(board: unknown) {
    this.cells = Array.isArray(board)
      ? board.map((line) => typeof line === 'string' ? line.trim().split(/\s+/).filter(Boolean) : [])
      : []
  }

  private connected(player: 'O' | 'X'): boolean {
    const queue: Cell[] = []
    const visited = new Set<string>()
    const lastRow = this.cells.length - 1

    for (let row = 0; row < this.cells.length; row++) {
      const columns = this.cells[row] ?? []
      for (let column = 0; column < columns.length; column++) {
        const onStartEdge = player === 'O' ? row === 0 : column === 0
        if (onStartEdge && columns[column] === player) {
          queue.push([row, column])
          visited.add(`${row},${column}`)
        }
      }
    }

    const directions: Cell[] = [
      [0, -1], [0, 1],
      [-1, 0], [-1, 1],
      [1, 0], [1, -1],
    ]
    for (let index = 0; index < queue.length; index++) {
      const [row, column] = queue[index]!
      const onFinishEdge = player === 'O'
        ? row === lastRow
        : column === (this.cells[row]?.length ?? 0) - 1
      if (onFinishEdge) return true

      for (const [rowOffset, columnOffset] of directions) {
        const nextRow = row + rowOffset
        const nextColumn = column + columnOffset
        const key = `${nextRow},${nextColumn}`
        if (
          nextRow >= 0 && nextRow < this.cells.length &&
          nextColumn >= 0 && nextColumn < (this.cells[nextRow]?.length ?? 0) &&
          this.cells[nextRow]?.[nextColumn] === player && !visited.has(key)
        ) {
          visited.add(key)
          queue.push([nextRow, nextColumn])
        }
      }
    }
    return false
  }

  public winner(): string {
    if (this.connected('O')) return 'O'
    if (this.connected('X')) return 'X'
    return ''
  }
}
