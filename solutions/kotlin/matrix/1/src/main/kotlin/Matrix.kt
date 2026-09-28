class Matrix(private val matrixAsString: String) {
    private val rows: List<List<Int>> = matrixAsString.trim().lines()
        .filter { it.isNotBlank() }
        .map { line -> line.trim().split(Regex("\\s+")).map(String::toInt) }

    fun column(colNr: Int): List<Int> {
        require(colNr > 0) { "Column numbers are one-based" }
        return rows.map { row -> row[colNr - 1] }
    }

    fun row(rowNr: Int): List<Int> {
        require(rowNr > 0) { "Row numbers are one-based" }
        return rows[rowNr - 1]
    }
}
