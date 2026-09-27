//
// This is only a SKELETON file for the 'Sublist' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class List {
  constructor(values = []) {
    this.values = values;
  }

  compare(other) {
    const isSublist = (small, large) => {
      if (small.length === 0) return true;
      for (let start = 0; start <= large.length - small.length; start += 1) {
        if (small.every((value, index) => value === large[start + index])) return true;
      }
      return false;
    };

    if (this.values.length === other.values.length && isSublist(this.values, other.values)) {
      return 'EQUAL';
    }
    if (isSublist(this.values, other.values)) return 'SUBLIST';
    if (isSublist(other.values, this.values)) return 'SUPERLIST';
    return 'UNEQUAL';
  }
}
