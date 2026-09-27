//
// This is only a SKELETON file for the 'Linked List' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class LinkedList {
  constructor() {
    this.items = [];
  }

  push() {
    this.items.push(...arguments);
  }

  pop() {
    return this.items.pop();
  }

  shift() {
    return this.items.shift();
  }

  unshift() {
    this.items.unshift(...arguments);
  }

  delete(value) {
    const index = this.items.indexOf(value);
    if (index !== -1) this.items.splice(index, 1);
  }

  count() {
    return this.items.length;
  }
}
