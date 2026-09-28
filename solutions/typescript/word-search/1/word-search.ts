type Location = { start: [number, number]; end: [number, number] }

export class WordSearch {
  private readonly grid: string[][]

  constructor(grid: string[]) {
    this.grid = grid.map((row) => [...row])
  }

  public find(words: string[]): Record<string, Location | undefined> {
    const result: Record<string, Location | undefined> = {}
    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],             [0, 1],
      [1, -1],  [1, 0],    [1, 1],
    ] as const

    for (const word of words) {
      let found: Location | undefined
      search: for (let row = 0; row < this.grid.length; row++) {
        for (let column = 0; column < (this.grid[row]?.length ?? 0); column++) {
          if (this.grid[row]?.[column] !== word[0]) continue
          for (const [rowStep, columnStep] of directions) {
            let matches = true
            for (let index = 1; index < word.length; index++) {
              const nextRow = row + rowStep * index
              const nextColumn = column + columnStep * index
              if (this.grid[nextRow]?.[nextColumn] !== word[index]) {
                matches = false
                break
              }
            }
            if (matches) {
              found = {
                start: [row + 1, column + 1],
                end: [row + 1 + rowStep * (word.length - 1), column + 1 + columnStep * (word.length - 1)],
              }
              break search
            }
          }
        }
      }
      result[word] = found
    }
    return result
  }
}
