object CryptoSquare {

    fun ciphertext(plaintext: String): String {
        val normalized = plaintext.lowercase().filter { it.isLetterOrDigit() }
        if (normalized.isEmpty()) return ""

        var columns = 1
        var rows: Int
        while (true) {
            rows = (normalized.length + columns - 1) / columns
            if (rows * columns >= normalized.length && columns >= rows && columns - rows <= 1) break
            columns++
        }

        return (0 until columns).joinToString(" ") { column ->
            buildString(rows) {
                for (row in 0 until rows) {
                    val index = row * columns + column
                    append(if (index < normalized.length) normalized[index] else ' ')
                }
            }
        }
    }
}
