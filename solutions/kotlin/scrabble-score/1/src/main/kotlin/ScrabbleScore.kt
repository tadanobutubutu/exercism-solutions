object ScrabbleScore {
    fun scoreLetter(c: Char): Int = when (c.uppercaseChar()) {
        in "AEIOULNRST" -> 1
        in "DG" -> 2
        in "BCMP" -> 3
        in "FHVWY" -> 4
        'K' -> 5
        'J', 'X' -> 8
        'Q', 'Z' -> 10
        else -> 0
    }

    fun scoreWord(word: String): Int = word.sumOf(::scoreLetter)
}
