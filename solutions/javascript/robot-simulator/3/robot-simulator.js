//
// This is only a SKELETON file for the 'Robot Simulator' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class InvalidInputError extends Error {
  constructor(message) {
    super(message || 'Invalid Input');
    this.name = 'InvalidInputError';
  }
}

export class Robot {
  constructor() {
    this._directions = ['north', 'east', 'south', 'west'];
    this._directionIndex = 0;
    this._x = 0;
    this._y = 0;
  }

  get bearing() {
    return this._directions[this._directionIndex];
  }

  get coordinates() {
    return [this._x, this._y];
  }

  place({ x, y, direction }) {
    const directionIndex = this._directions.indexOf(direction);
    if (directionIndex === -1 || !Number.isFinite(x) || !Number.isFinite(y)) {
      throw new InvalidInputError('Invalid robot position');
    }
    this._x = x;
    this._y = y;
    this._directionIndex = directionIndex;
  }

  evaluate(instructions) {
    for (const instruction of instructions) {
      if (instruction === 'R') this._directionIndex = (this._directionIndex + 1) % 4;
      else if (instruction === 'L') this._directionIndex = (this._directionIndex + 3) % 4;
      else if (instruction === 'A') {
        if (this.bearing === 'north') this._y += 1;
        else if (this.bearing === 'east') this._x += 1;
        else if (this.bearing === 'south') this._y -= 1;
        else this._x -= 1;
      } else {
        throw new InvalidInputError('Invalid instruction');
      }
    }
  }
}
