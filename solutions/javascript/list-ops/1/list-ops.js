export class List {
  constructor(values = []) {
    this.values = values;
  }

  append(other) {
    const values = [];
    for (const value of this.values) values[values.length] = value;
    for (const value of other.values) values[values.length] = value;
    return new List(values);
  }

  concat(others) {
    const values = [];
    for (const value of this.values) values[values.length] = value;
    for (const list of others.values) {
      for (const value of list.values) values[values.length] = value;
    }
    return new List(values);
  }

  filter(predicate) {
    const values = [];
    for (const value of this.values) {
      if (predicate(value)) values[values.length] = value;
    }
    return new List(values);
  }

  map(transform) {
    const values = [];
    for (const value of this.values) values[values.length] = transform(value);
    return new List(values);
  }

  length() {
    let count = 0;
    for (const _ of this.values) count += 1;
    return count;
  }

  foldl(combine, initial) {
    let accumulator = initial;
    for (const value of this.values) accumulator = combine(accumulator, value);
    return accumulator;
  }

  foldr(combine, initial) {
    let accumulator = initial;
    for (let index = this.values.length - 1; index >= 0; index -= 1) {
      accumulator = combine(accumulator, this.values[index]);
    }
    return accumulator;
  }

  reverse() {
    const values = [];
    for (let index = this.values.length - 1; index >= 0; index -= 1) {
      values[values.length] = this.values[index];
    }
    return new List(values);
  }
}
