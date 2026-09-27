//
// This is only a SKELETON file for the 'Go Counting' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class GoCounting {
  constructor(board) {
    this.board = board;
    this.width = board[0]?.length ?? 0;
    this.height = board.length;
  }

  getTerritory(x, y) {
    if (!Number.isInteger(x) || !Number.isInteger(y) || x < 0 || x >= this.width || y < 0 || y >= this.height) {
      return { error: 'Invalid coordinate' };
    }
    if (this.board[y][x] !== ' ') return { owner: 'NONE', territory: [] };

    const territory = [];
    const visited = new Set([`${x},${y}`]);
    const queue = [[x, y]];
    const adjacentOwners = new Set();
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    while (queue.length > 0) {
      const [currentX, currentY] = queue.shift();
      territory.push([currentX, currentY]);
      for (const [dx, dy] of directions) {
        const nextX = currentX + dx;
        const nextY = currentY + dy;
        if (nextX < 0 || nextX >= this.width || nextY < 0 || nextY >= this.height) continue;
        const cell = this.board[nextY][nextX];
        if (cell === 'B' || cell === 'W') {
          adjacentOwners.add(cell);
          continue;
        }
        const key = `${nextX},${nextY}`;
        if (!visited.has(key)) {
          visited.add(key);
          queue.push([nextX, nextY]);
        }
      }
    }

    territory.sort(([x1, y1], [x2, y2]) => x1 - x2 || y1 - y2);
    const owner = adjacentOwners.size === 1
      ? (adjacentOwners.has('B') ? 'BLACK' : 'WHITE')
      : 'NONE';
    return { owner, territory };
  }

  getTerritories() {
    const territories = { territoryBlack: [], territoryWhite: [], territoryNone: [] };
    const visited = new Set();
    for (let x = 0; x < this.width; x += 1) {
      for (let y = 0; y < this.height; y += 1) {
        if (this.board[y][x] !== ' ') continue;
        const key = `${x},${y}`;
        if (visited.has(key)) continue;
        const result = this.getTerritory(x, y);
        for (const [tx, ty] of result.territory) visited.add(`${tx},${ty}`);
        const property = {
          BLACK: 'territoryBlack',
          WHITE: 'territoryWhite',
          NONE: 'territoryNone',
        }[result.owner];
        territories[property].push(...result.territory);
      }
    }
    return territories;
  }
}
