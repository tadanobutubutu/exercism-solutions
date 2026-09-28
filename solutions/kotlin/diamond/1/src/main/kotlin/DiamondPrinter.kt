class DiamondPrinter {
    fun printToList(letter: Char): List<String> {
        val highest = letter - 'A'
        require(highest >= 0) { "Input must be an uppercase letter" }
        return (0..2 * highest).map { row ->
            val letterIndex = if (row <= highest) row else 2 * highest - row
            val current = 'A' + letterIndex
            val outerSpaces = " ".repeat(highest - letterIndex)
            if (letterIndex == 0) {
                "$outerSpaces$current$outerSpaces"
            } else {
                "$outerSpaces$current${" ".repeat(2 * letterIndex - 1)}$current$outerSpaces"
            }
        }
    }
}
