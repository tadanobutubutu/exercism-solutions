class WordSearch {
  constructor(grid) {
    this.grid = grid.map((row) => [...row]);
    this.height = this.grid.length;
    this.width = this.grid.reduce((width, row) => Math.max(width, row.length), 0);
  }

  find(words) {
    const directions = [
      [-1, -1], [-1, 0], [-1, 1],
      [0, -1],            [0, 1],
      [1, -1],  [1, 0],  [1, 1],
    ];
    const results = {};

    for (const word of words) {
      let location;
      for (let row = 0; row < this.height && !location; row += 1) {
        for (let column = 0; column < this.grid[row].length && !location; column += 1) {
          if (this.grid[row][column] !== word[0]) continue;

          for (const [rowStep, columnStep] of directions) {
            let offset = 1;
            while (offset < word.length) {
              const nextRow = row + rowStep * offset;
              const nextColumn = column + columnStep * offset;
              if (
                nextRow < 0 || nextRow >= this.height ||
                nextColumn < 0 || nextColumn >= this.grid[nextRow].length ||
                this.grid[nextRow][nextColumn] !== word[offset]
              ) break;
              offset += 1;
            }

            if (offset === word.length) {
              location = {
                start: [row + 1, column + 1],
                end: [row + rowStep * (word.length - 1) + 1,
                  column + columnStep * (word.length - 1) + 1],
              };
              break;
            }
          }
        }
      }
      results[word] = location;
    }

    return results;
  }
}

export default WordSearch;
