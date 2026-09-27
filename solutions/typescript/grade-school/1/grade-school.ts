export class GradeSchool {
  private readonly studentsByGrade = new Map<number, Set<string>>()

  roster(): Record<number, string[]> {
    const roster: Record<number, string[]> = {}
    for (const grade of [...this.studentsByGrade.keys()].sort((a, b) => a - b)) {
      roster[grade] = this.grade(grade)
    }
    return roster
  }

  add(student: string, grade: number): void {
    for (const [existingGrade, students] of this.studentsByGrade) {
      students.delete(student)
      if (students.size === 0) this.studentsByGrade.delete(existingGrade)
    }

    const students = this.studentsByGrade.get(grade) ?? new Set<string>()
    students.add(student)
    this.studentsByGrade.set(grade, students)
  }

  grade(grade: number): string[] {
    return [...(this.studentsByGrade.get(grade) ?? [])].sort()
  }
}
