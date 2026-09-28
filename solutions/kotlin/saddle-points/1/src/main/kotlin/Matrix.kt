data class MatrixCoordinate(val row: Int, val col: Int)

class Matrix(private val rows: List<List<Int>>) {
    val saddlePoints: Set<MatrixCoordinate>
        get() {
            if (rows.isEmpty() || rows.any { it.isEmpty() }) return emptySet()
            val columnCount = rows.first().size
            if (rows.any { it.size != columnCount }) return emptySet()

            val columnMinimums = (0 until columnCount).map { column ->
                rows.minOf { it[column] }
            }
            return buildSet {
                rows.forEachIndexed { rowIndex, row ->
                    val rowMaximum = row.maxOrNull() ?: return@forEachIndexed
                    row.forEachIndexed { columnIndex, value ->
                        if (value == rowMaximum && value == columnMinimums[columnIndex]) {
                            add(MatrixCoordinate(rowIndex + 1, columnIndex + 1))
                        }
                    }
                }
            }
        }
}
