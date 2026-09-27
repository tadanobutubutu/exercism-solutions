//
// This is only a SKELETON file for the 'Circular Buffer' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

class CircularBuffer {
  constructor(capacity) {
    this.capacity = capacity;
    this.items = [];
  }

  write(value) {
    if (this.items.length >= this.capacity) throw new BufferFullError();
    this.items.push(value);
  }

  read() {
    if (this.items.length === 0) throw new BufferEmptyError();
    return this.items.shift();
  }

  forceWrite(value) {
    if (this.items.length >= this.capacity) this.items.shift();
    this.items.push(value);
  }

  clear() {
    this.items = [];
  }
}

export default CircularBuffer;

export class BufferFullError extends Error {
  constructor() {
    super('Buffer full');
    this.name = 'BufferFullError';
  }
}

export class BufferEmptyError extends Error {
  constructor() {
    super('Buffer empty');
    this.name = 'BufferEmptyError';
  }
}
