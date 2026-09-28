object PascalsTriangle {

    fun computeTriangle(rows: Int): List<List<Int>> {
        if (rows <= 0) return emptyList()
        val triangle = mutableListOf<List<Int>>()
        repeat(rows) {
            val previous = triangle.lastOrNull().orEmpty()
            val next = MutableList(previous.size + 1) { 1 }
            for (index in 1 until next.lastIndex) {
                next[index] = previous[index - 1] + previous[index]
            }
            triangle.add(next)
        }
        return triangle
    }
}
