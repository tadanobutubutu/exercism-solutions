export class Triangle {
  constructor(...sides) {
    this.sides = sides;
    this.isValid =
      sides.length === 3 &&
      sides.every((side) => Number.isFinite(side) && side > 0) &&
      sides[0] + sides[1] > sides[2] &&
      sides[0] + sides[2] > sides[1] &&
      sides[1] + sides[2] > sides[0];
  }

  get isEquilateral() {
    return this.isValid && this.sides.every((side) => side === this.sides[0]);
  }

  get isIsosceles() {
    return (
      this.isValid &&
      (this.sides[0] === this.sides[1] ||
        this.sides[0] === this.sides[2] ||
        this.sides[1] === this.sides[2])
    );
  }

  get isScalene() {
    return this.isValid && new Set(this.sides).size === 3;
  }
}
