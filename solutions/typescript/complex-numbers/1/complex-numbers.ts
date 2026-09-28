export class ComplexNumber {
  constructor(
    private readonly realValue: number,
    private readonly imaginaryValue: number
  ) {}

  public get real(): number {
    return this.realValue
  }

  public get imag(): number {
    return this.imaginaryValue
  }

  public add(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real + other.real, this.imag + other.imag)
  }

  public sub(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(this.real - other.real, this.imag - other.imag)
  }

  public div(other: ComplexNumber): ComplexNumber {
    const denominator = other.real ** 2 + other.imag ** 2
    if (denominator === 0) throw new RangeError('cannot divide by zero')
    return new ComplexNumber(
      (this.real * other.real + this.imag * other.imag) / denominator,
      (this.imag * other.real - this.real * other.imag) / denominator
    )
  }

  public mul(other: ComplexNumber): ComplexNumber {
    return new ComplexNumber(
      this.real * other.real - this.imag * other.imag,
      this.imag * other.real + this.real * other.imag
    )
  }

  public get abs(): number {
    return Math.hypot(this.real, this.imag)
  }

  public get conj(): ComplexNumber {
    return new ComplexNumber(this.real, this.imag === 0 ? 0 : -this.imag)
  }

  public get exp(): ComplexNumber {
    const magnitude = Math.exp(this.real)
    return new ComplexNumber(
      magnitude * Math.cos(this.imag),
      magnitude * Math.sin(this.imag)
    )
  }
}
