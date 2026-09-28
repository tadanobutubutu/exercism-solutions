type Position = readonly [number, number]

type Positions = {
  white: Position
  black: Position
}

export class QueenAttack {
  public readonly black: Position
  public readonly white: Position

  constructor({ white = [7, 3], black = [0, 3] }: Partial<Positions> = {}) {
    const isOnBoard = (position: Position): boolean =>
      position.length === 2 && position.every((coordinate) =>
        Number.isInteger(coordinate) && coordinate >= 0 && coordinate <= 7
      )
    if (!isOnBoard(white) || !isOnBoard(black)) {
      throw new Error('Queen must be placed on the board')
    }
    if (white[0] === black[0] && white[1] === black[1]) {
      throw new Error('Queens cannot share the same space')
    }
    this.white = [...white]
    this.black = [...black]
  }

  toString(): string {
    const rows: string[] = []
    for (let row = 0; row < 8; row++) {
      const cells = Array<string>(8).fill('_')
      if (this.black[0] === row) cells[this.black[1]] = 'B'
      if (this.white[0] === row) cells[this.white[1]] = 'W'
      rows.push(cells.join(' '))
    }
    return rows.join('\n')
  }

  get canAttack(): boolean {
    const rowDistance = Math.abs(this.white[0] - this.black[0])
    const columnDistance = Math.abs(this.white[1] - this.black[1])
    return rowDistance === 0 || columnDistance === 0 || rowDistance === columnDistance
  }
}
