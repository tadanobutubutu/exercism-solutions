export class Rational {
  constructor(
    public numerator: number,
    public denominator: number
  ) {}

  add(other: Rational): Rational {
    return new Rational(
      this.numerator * other.denominator + other.numerator * this.denominator,
      this.denominator * other.denominator
    ).reduce()
  }

  sub(other: Rational): Rational {
    return new Rational(
      this.numerator * other.denominator - other.numerator * this.denominator,
      this.denominator * other.denominator
    ).reduce()
  }

  mul(other: Rational): Rational {
    return new Rational(
      this.numerator * other.numerator,
      this.denominator * other.denominator
    ).reduce()
  }

  div(other: Rational): Rational {
    if (other.numerator === 0) throw new RangeError('Cannot divide by zero')
    return new Rational(
      this.numerator * other.denominator,
      this.denominator * other.numerator
    ).reduce()
  }

  abs(): Rational {
    return new Rational(Math.abs(this.numerator), Math.abs(this.denominator)).reduce()
  }

  exprational(exponent: number): Rational {
    if (!Number.isInteger(exponent)) throw new RangeError('Exponent must be an integer')
    if (exponent < 0) {
      if (this.numerator === 0) throw new RangeError('Zero cannot have a negative exponent')
      return new Rational(
        this.denominator ** -exponent,
        this.numerator ** -exponent
      ).reduce()
    }
    return new Rational(
      this.numerator ** exponent,
      this.denominator ** exponent
    ).reduce()
  }

  expreal(real: number): number {
    const reduced = this.reduce()
    // A negative base has a real result only when its reduced denominator is odd.
    const base = real
    const { numerator, denominator } = reduced
    if (base < 0 && denominator % 2 === 0) return Number.NaN
    if (base < 0) {
      const magnitude = Math.pow(Math.abs(base), numerator / denominator)
      return Math.abs(numerator) % 2 === 0 ? magnitude : -magnitude
    }
    return Math.pow(base, numerator / denominator)
  }

  reduce(): Rational {
    let numerator = this.numerator
    let denominator = this.denominator
    if (denominator === 0) throw new RangeError('Denominator cannot be zero')
    if (denominator < 0) {
      numerator = -numerator
      denominator = -denominator
    }
    const divisor = gcd(Math.abs(numerator), denominator)
    return new Rational(numerator / divisor, denominator / divisor)
  }
}

function gcd(a: number, b: number): number {
  while (b !== 0) [a, b] = [b, a % b]
  return a || 1
}
