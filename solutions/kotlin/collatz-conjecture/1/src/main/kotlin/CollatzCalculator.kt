object CollatzCalculator {
    fun computeStepCount(start: Int): Int {
        require(start > 0) { "Start must be positive" }
        var value = start.toLong()
        var steps = 0
        while (value != 1L) {
            value = if (value % 2L == 0L) value / 2L else 3L * value + 1L
            steps++
        }
        return steps
    }
}
