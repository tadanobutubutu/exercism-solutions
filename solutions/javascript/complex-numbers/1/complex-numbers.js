//
// This is only a SKELETON file for the 'Complex Numbers' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class ComplexNumber {
  constructor(real, imag) {
    this.realPart = real;
    this.imaginaryPart = imag;
  }

  get real() {
    return this.realPart;
  }

  get imag() {
    return this.imaginaryPart;
  }

  add(other) {
    return new ComplexNumber(this.real + other.real, this.imag + other.imag);
  }

  sub(other) {
    return new ComplexNumber(this.real - other.real, this.imag - other.imag);
  }

  div(other) {
    const denominator = other.real ** 2 + other.imag ** 2;
    return new ComplexNumber(
      (this.real * other.real + this.imag * other.imag) / denominator,
      (this.imag * other.real - this.real * other.imag) / denominator,
    );
  }

  mul(other) {
    return new ComplexNumber(
      this.real * other.real - this.imag * other.imag,
      this.imag * other.real + this.real * other.imag,
    );
  }

  get abs() {
    return Math.hypot(this.real, this.imag);
  }

  get conj() {
    return new ComplexNumber(this.real, this.imag === 0 ? 0 : -this.imag);
  }

  get exp() {
    const magnitude = Math.exp(this.real);
    return new ComplexNumber(magnitude * Math.cos(this.imag), magnitude * Math.sin(this.imag));
  }
}
