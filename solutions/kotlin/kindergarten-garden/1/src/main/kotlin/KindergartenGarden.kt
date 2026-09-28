class KindergartenGarden(private val diagram: String) {
    private val students = listOf(
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred",
        "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    )
    private val rows = diagram.trim().split('\n').map { it.trimEnd('\r') }

    fun getPlantsOfStudent(student: String): List<String> {
        val studentIndex = students.indexOf(student)
        require(studentIndex >= 0) { "Unknown student" }
        val start = studentIndex * 2
        val plants = listOf(rows[0][start], rows[0][start + 1], rows[1][start], rows[1][start + 1])
        return plants.map { plant ->
            when (plant) {
                'G' -> "grass"
                'C' -> "clover"
                'R' -> "radishes"
                'V' -> "violets"
                else -> error("Unknown plant")
            }
        }
    }
}
