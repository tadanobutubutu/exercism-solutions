object SpiralMatrix {

    fun ofSize(size: Int): Array<IntArray> {
        if (size <= 0) return emptyArray()
        val matrix = Array(size) { IntArray(size) }
        var top = 0
        var bottom = size - 1
        var left = 0
        var right = size - 1
        var value = 1

        while (top <= bottom && left <= right) {
            for (column in left..right) matrix[top][column] = value++
            top++
            for (row in top..bottom) matrix[row][right] = value++
            right--
            if (top <= bottom) {
                for (column in right downTo left) matrix[bottom][column] = value++
                bottom--
            }
            if (left <= right) {
                for (row in bottom downTo top) matrix[row][left] = value++
                left++
            }
        }
        return matrix
    }
}
