object Transpose {

    fun transpose(input: List<String>): List<String> {
        val width = input.maxOfOrNull { it.length } ?: return emptyList()
        return (0 until width).map { column ->
            val lastRow = input.indexOfLast { column < it.length }
            (0..lastRow).joinToString("") { row -> input[row].getOrNull(column)?.toString() ?: " " }
        }
    }
}
