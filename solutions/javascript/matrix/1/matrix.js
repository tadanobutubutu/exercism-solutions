//
// This is only a SKELETON file for the 'Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Matrix {
  constructor(matrix) {
    this.matrix = matrix.split('\n').map((row) => row.trim().split(/\s+/).map(Number));
  }

  get rows() {
    return this.matrix.map((row) => [...row]);
  }

  get columns() {
    const width = this.matrix[0]?.length ?? 0;
    return Array.from({ length: width }, (_, column) =>
      this.matrix.map((row) => row[column]));
  }
}
