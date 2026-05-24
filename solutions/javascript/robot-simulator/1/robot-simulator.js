const DIRECTIONS = ['north', 'east', 'south', 'west'];

export class InvalidInputError extends Error {
  constructor(message) {
    super();
    this.message = message || 'Invalid Input';
  }
}

export class Robot {
  constructor() {
    this._bearing = 'north';
    this._x = 0;
    this._y = 0;
  }

  get bearing() {
    return this._bearing;
  }

  get coordinates() {
    return [this._x, this._y];
  }

  place({ x, y, direction }) {
    if (!DIRECTIONS.includes(direction)) {
      throw new InvalidInputError('Invalid direction');
    }
    this._x = x;
    this._y = y;
    this._bearing = direction;
  }

  evaluate(instructions) {
    for (const cmd of instructions) {
      if (cmd === 'R') {
        const idx = (DIRECTIONS.indexOf(this._bearing) + 1) % 4;
        this._bearing = DIRECTIONS[idx];
      } else if (cmd === 'L') {
        const idx = (DIRECTIONS.indexOf(this._bearing) + 3) % 4;
        this._bearing = DIRECTIONS[idx];
      } else if (cmd === 'A') {
        if (this._bearing === 'north') this._y++;
        else if (this._bearing === 'south') this._y--;
        else if (this._bearing === 'east') this._x++;
        else if (this._bearing === 'west') this._x--;
      }
    }
  }
}
