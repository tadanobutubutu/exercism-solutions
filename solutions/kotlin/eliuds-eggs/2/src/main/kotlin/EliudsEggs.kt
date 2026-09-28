object EliudsEggs {

    fun eggCount(number: Int): Int {
        var bits = number
        var count = 0
        while (bits > 0) {
            count += bits and 1
            bits = bits ushr 1
        }
        return count
    }
}
