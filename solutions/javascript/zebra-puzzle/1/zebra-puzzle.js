const positions = (items) => {
  const result = [];
  const permute = (index, order) => {
    if (index === order.length) {
      result.push(Object.fromEntries(order.map((item, i) => [item, i + 1])));
      return;
    }
    for (let next = index; next < order.length; next += 1) {
      [order[index], order[next]] = [order[next], order[index]];
      permute(index + 1, order);
      [order[index], order[next]] = [order[next], order[index]];
    }
  };
  permute(0, [...items]);
  return result;
};

const adjacent = (first, second) => Math.abs(first - second) === 1;

export class ZebraPuzzle {
  constructor() {
    this.solve();
  }

  solve() {
    if (this.solution) return this.solution;
    const colors = positions(['red', 'green', 'ivory', 'yellow', 'blue']);
    const nationalities = positions(['Englishman', 'Spaniard', 'Ukrainian', 'Norwegian', 'Japanese']);
    const beverages = positions(['coffee', 'tea', 'milk', 'orange juice', 'water']);
    const pets = positions(['dog', 'snails', 'fox', 'horse', 'zebra']);
    const hobbies = positions(['dancing', 'painting', 'reading', 'football', 'chess']);

    for (const color of colors) {
      if (color.green !== color.ivory + 1) continue;
      for (const nationality of nationalities) {
        if (
          nationality.Norwegian !== 1 ||
          nationality.Englishman !== color.red ||
          !adjacent(nationality.Norwegian, color.blue)
        ) continue;

        for (const beverage of beverages) {
          if (
            beverage.coffee !== color.green ||
            beverage.tea !== nationality.Ukrainian ||
            beverage.milk !== 3
          ) continue;

          for (const pet of pets) {
            if (pet.dog !== nationality.Spaniard) continue;

            for (const hobby of hobbies) {
              if (
                hobby.chess !== nationality.Japanese ||
                hobby.painting !== color.yellow ||
                pet.snails !== hobby.dancing ||
                hobby.football !== beverage['orange juice'] ||
                !adjacent(hobby.painting, pet.horse) ||
                !adjacent(hobby.reading, pet.fox)
              ) continue;

              this.solution = { nationality, beverage, pet };
              return this.solution;
            }
          }
        }
      }
    }
    throw new Error('No solution found');
  }

  waterDrinker() {
    const { nationality, beverage } = this.solve();
    return Object.keys(nationality).find((person) => nationality[person] === beverage.water);
  }

  zebraOwner() {
    const { nationality, pet } = this.solve();
    return Object.keys(nationality).find((person) => nationality[person] === pet.zebra);
  }
}
