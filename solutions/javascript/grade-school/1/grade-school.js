//
// This is only a SKELETON file for the 'Grade School' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class GradeSchool {
  constructor() {
    this.students = new Map();
  }

  roster() {
    return [...this.students.entries()]
      .sort(([gradeA], [gradeB]) => gradeA - gradeB)
      .flatMap(([, names]) => [...names].sort());
  }

  add(name, grade) {
    if ([...this.students.values()].some((names) => names.has(name))) return false;
    if (!this.students.has(grade)) this.students.set(grade, new Set());
    this.students.get(grade).add(name);
    return true;
  }

  grade(grade) {
    return [...(this.students.get(grade) ?? [])].sort();
  }
}
