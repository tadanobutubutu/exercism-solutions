data class FlowerFieldBoard(private val board: List<String>) {

    fun withNumbers(): List<String> {
        if (board.isEmpty()) return emptyList()
        val columns = board.first().length
        return board.indices.map { row ->
            buildString(columns) {
                for (column in 0 until columns) {
                    if (board[row][column] == '*') {
                        append('*')
                    } else {
                        var adjacentFlowers = 0
                        for (neighborRow in maxOf(0, row - 1)..minOf(board.lastIndex, row + 1)) {
                            for (neighborColumn in maxOf(0, column - 1)..minOf(columns - 1, column + 1)) {
                                if (board[neighborRow][neighborColumn] == '*') adjacentFlowers++
                            }
                        }
                        append(if (adjacentFlowers == 0) ' ' else ('0'.code + adjacentFlowers).toChar())
                    }
                }
            }
        }
    }
}
