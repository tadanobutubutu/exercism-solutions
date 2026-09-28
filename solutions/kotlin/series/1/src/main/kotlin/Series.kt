object Series {
    fun slices(n: Int, s: String): List<List<Int>> {
        require(n > 0) { "Slice length must be positive" }
        require(n <= s.length) { "Slice length cannot exceed the series length" }
        return (0..s.length - n).map { start ->
            s.substring(start, start + n).map(Char::digitToInt)
        }
    }
}
