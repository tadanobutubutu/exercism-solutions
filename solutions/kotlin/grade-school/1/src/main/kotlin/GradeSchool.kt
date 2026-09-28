class School {
    private val studentsByGrade = sortedMapOf<Int, MutableSet<String>>()
    private val enrolledStudents = mutableSetOf<String>()

    fun add(student: String, grade: Int) {
        require(enrolledStudents.add(student)) { "Student is already enrolled" }
        studentsByGrade.getOrPut(grade) { sortedSetOf() }.add(student)
    }

    fun grade(grade: Int): List<String> = studentsByGrade[grade]?.toList() ?: emptyList()

    fun roster(): List<String> = studentsByGrade.values.flatMap { it.toList() }
}
