export class Triplet {
  constructor(a, b, c) {
    [this.a, this.b, this.c] = [a, b, c].sort((left, right) => left - right);
  }

  toArray() {
    return [this.a, this.b, this.c];
  }
}

const gcd = (a, b) => (b === 0 ? a : gcd(b, a % b));

export const triplets = ({ sum, minFactor = 1, maxFactor = sum }) => {
  const matches = [];

  // Euclid's formula generates every primitive Pythagorean triple. Its
  // perimeter is 2*m*(m+n), so the scale factor is determined by `sum`.
  for (let m = 2; 2 * m * (m + 1) <= sum; m += 1) {
    for (let n = 1; n < m; n += 1) {
      if (gcd(m, n) !== 1 || (m - n) % 2 === 0) continue;

      const perimeter = 2 * m * (m + n);
      if (sum % perimeter !== 0) continue;

      const scale = sum / perimeter;
      const sides = [
        scale * (m * m - n * n),
        scale * (2 * m * n),
        scale * (m * m + n * n),
      ];
      if (sides.every(side => side >= minFactor && side <= maxFactor)) {
        matches.push(new Triplet(...sides));
      }
    }
  }

  return matches.sort((left, right) =>
    left.a - right.a || left.b - right.b || left.c - right.c,
  );
};
