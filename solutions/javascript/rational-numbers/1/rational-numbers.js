//
// This is only a SKELETON file for the 'Rational Numbers' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Rational {
  constructor(numerator, denominator) {
    if (denominator === 0) throw new RangeError('denominator must not be zero');
    const divisor = Rational.gcd(Math.abs(numerator), Math.abs(denominator));
    const sign = denominator < 0 ? -1 : 1;
    this.numerator = (numerator / divisor) * sign;
    this.denominator = Math.abs(denominator / divisor);
  }

  add(other) {
    return new Rational(
      this.numerator * other.denominator + other.numerator * this.denominator,
      this.denominator * other.denominator,
    );
  }

  sub(other) {
    return new Rational(
      this.numerator * other.denominator - other.numerator * this.denominator,
      this.denominator * other.denominator,
    );
  }

  mul(other) {
    return new Rational(this.numerator * other.numerator, this.denominator * other.denominator);
  }

  div(other) {
    return new Rational(this.numerator * other.denominator, this.denominator * other.numerator);
  }

  abs() {
    return new Rational(Math.abs(this.numerator), this.denominator);
  }

  exprational(power) {
    if (power < 0) {
      return new Rational(this.denominator ** -power, this.numerator ** -power);
    }
    return new Rational(this.numerator ** power, this.denominator ** power);
  }

  expreal(real) {
    const root = real < 0 && this.denominator % 2 !== 0
      ? -((-real) ** (1 / this.denominator))
      : real ** (1 / this.denominator);
    return root ** this.numerator;
  }

  reduce() {
    return new Rational(this.numerator, this.denominator);
  }

  static gcd(a, b) {
    while (b !== 0) [a, b] = [b, a % b];
    return a || 1;
  }
}
