//
// This is only a SKELETON file for the 'Allergies' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Allergies {
  constructor(score) {
    this.score = score;
  }

  list() {
    const allergens = [
      'eggs',
      'peanuts',
      'shellfish',
      'strawberries',
      'tomatoes',
      'chocolate',
      'pollen',
      'cats',
    ];
    return allergens.filter((_, index) => (this.score & (1 << index)) !== 0);
  }

  allergicTo(item) {
    return this.list().includes(item);
  }
}
