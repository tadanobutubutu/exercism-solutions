object Acronym {
    fun generate(phrase: String) : String {
        return phrase
            .split(Regex("[\\s-]+"))
            .mapNotNull { word -> word.firstOrNull(Char::isLetter) }
            .joinToString("")
            .uppercase()
    }
}
