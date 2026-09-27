//
// This is only a SKELETON file for the 'Custom Set' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class CustomSet {
  constructor(elements = []) {
    this.elements = new Set(elements);
  }

  empty() {
    return this.elements.size === 0;
  }

  contains(value) {
    return this.elements.has(value);
  }

  add(value) {
    return new CustomSet([...this.elements, value]);
  }

  subset(other) {
    return [...this.elements].every(value => other.elements.has(value));
  }

  disjoint(other) {
    return [...this.elements].every(value => !other.elements.has(value));
  }

  eql(other) {
    return this.elements.size === other.elements.size && this.subset(other);
  }

  union(other) {
    return new CustomSet([...this.elements, ...other.elements]);
  }

  intersection(other) {
    return new CustomSet([...this.elements].filter(value => other.elements.has(value)));
  }

  difference(other) {
    return new CustomSet([...this.elements].filter(value => !other.elements.has(value)));
  }
}
