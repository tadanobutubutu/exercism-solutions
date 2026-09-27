const DEFAULT_STUDENTS = [
  'Alice', 'Bob', 'Charlie', 'David', 'Eve', 'Fred',
  'Ginny', 'Harriet', 'Ileana', 'Joseph', 'Kincaid', 'Larry',
];

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
};

export class Garden {
  constructor(diagram, students = DEFAULT_STUDENTS) {
    this.rows = diagram.split('\n');
    this.students = [...students].sort();
  }

  plants(student) {
    const start = this.students.indexOf(student) * 2;
    return this.rows.flatMap((row) => Array.from(row.slice(start, start + 2)))
      .map((code) => PLANT_CODES[code]);
  }
}
