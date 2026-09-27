export class Triangle {
  private readonly sides: number[]

  constructor(...sides: number[]) {
    this.sides = sides
  }

  private get isValid(): boolean {
    if (this.sides.length !== 3 || this.sides.some((side) => side <= 0)) {
      return false
    }

    const [a, b, c] = this.sides
    return a + b >= c && a + c >= b && b + c >= a
  }

  get isEquilateral(): boolean {
    return this.isValid && this.sides[0] === this.sides[1] && this.sides[1] === this.sides[2]
  }

  get isIsosceles(): boolean {
    return (
      this.isValid &&
      (this.sides[0] === this.sides[1] ||
        this.sides[0] === this.sides[2] ||
        this.sides[1] === this.sides[2])
    )
  }

  get isScalene(): boolean {
    return (
      this.isValid &&
      this.sides[0] !== this.sides[1] &&
      this.sides[0] !== this.sides[2] &&
      this.sides[1] !== this.sides[2]
    )
  }
}
