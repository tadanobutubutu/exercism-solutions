//
// This is only a SKELETON file for the 'Simple Linked List' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Element {
  constructor(value, next = null) {
    this._value = value;
    this._next = next;
  }

  get value() {
    return this._value;
  }

  get next() {
    return this._next;
  }
}

export class List {
  constructor(values = []) {
    this._head = null;
    this._length = 0;
    for (const value of values) this.add(value);
  }

  add(nextValue) {
    const value = nextValue instanceof Element ? nextValue.value : nextValue;
    this._head = new Element(value, this._head);
    this._length += 1;
  }

  get length() {
    return this._length;
  }

  get head() {
    return this._head;
  }

  toArray() {
    const values = [];
    for (let element = this._head; element !== null; element = element.next) {
      values.push(element.value);
    }
    return values;
  }

  reverse() {
    return new List(this.toArray());
  }
}
