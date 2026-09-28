//
// This is only a SKELETON file for the 'Kindergarten Garden' exercise.
// It's been provided as a convenience to get you started writing code faster.
//

const DEFAULT_STUDENTS: Student[] = [
  'Alice',
  'Bob',
  'Charlie',
  'David',
  'Eve',
  'Fred',
  'Ginny',
  'Harriet',
  'Ileana',
  'Joseph',
  'Kincaid',
  'Larry',
]

const PLANT_CODES = {
  G: 'grass',
  V: 'violets',
  R: 'radishes',
  C: 'clover',
} as const

type Student = string
type Plant = (typeof PLANT_CODES)[keyof typeof PLANT_CODES]
type Plants = Plant[]
type Pots = Plants[]

export class Garden {
  private readonly studentPlants: Map<Student, Plants>

  constructor(diagram: string, students = DEFAULT_STUDENTS) {
    const [top = '', bottom = ''] = diagram.split('\n')
    const orderedStudents = [...students].sort()
    this.studentPlants = new Map()
    for (let index = 0; index < orderedStudents.length; index++) {
      const start = index * 2
      const codes = [top[start], top[start + 1], bottom[start], bottom[start + 1]]
      this.studentPlants.set(
        orderedStudents[index]!,
        codes.map((code) => PLANT_CODES[code as keyof typeof PLANT_CODES])
      )
    }
  }

  public plants(student: Student): Plants {
    return [...(this.studentPlants.get(student) ?? [])]
  }
}
