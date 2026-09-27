// This is only a SKELETON file for the 'Robot Name' exercise. It's been
// provided as a convenience to get your started writing code faster.

const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const totalNames = 26 * 26 * 1000;

export class Robot {
  constructor() {
    this._name = Robot.createName();
  }

  get name() {
    return this._name;
  }

  reset() {
    this._name = Robot.createName();
  }

  static createName() {
    if (Robot.nextNameIndex >= Robot.namePool.length) {
      throw new Error('all robot names have been used');
    }
    const index = Robot.namePool[Robot.nextNameIndex++];

    const first = Math.floor(index / (26 * 1000));
    const second = Math.floor(index / 1000) % 26;
    const number = index % 1000;
    return `${alphabet[first]}${alphabet[second]}${String(number).padStart(3, '0')}`;
  }

  static releaseNames() {
    Robot.namePool = Robot.createNamePool();
    Robot.nextNameIndex = 0;
  }

  static createNamePool() {
    const even = [];
    const odd = [];
    for (let index = 0; index < totalNames; index += 1) {
      (index % 2 === 0 ? even : odd).push(index);
    }
    const shuffle = (values) => {
      for (let index = values.length - 1; index > 0; index -= 1) {
        const swapIndex = Math.floor(Math.random() * (index + 1));
        [values[index], values[swapIndex]] = [values[swapIndex], values[index]];
      }
    };
    shuffle(even);
    shuffle(odd);

    const lastEven = even.at(-1);
    const firstOdd = odd[0];
    if (Math.abs(lastEven - firstOdd) <= 1) {
      const replacementIndex = odd.findIndex((value, index) =>
        index > 0 && Math.abs(lastEven - value) > 1);
      [odd[0], odd[replacementIndex]] = [odd[replacementIndex], odd[0]];
    }
    return [...even, ...odd];
  }
}

Robot.namePool = Robot.createNamePool();
Robot.nextNameIndex = 0;
