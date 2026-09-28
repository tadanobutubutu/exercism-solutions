object Isogram {

    fun isIsogram(input: String): Boolean {
        val letters = input.filter(Char::isLetter).map(Char::lowercaseChar)
        return letters.distinct().size == letters.size
    }
}
