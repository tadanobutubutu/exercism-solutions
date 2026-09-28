object WordCount {
    private val wordPattern = Regex("[a-z0-9]+(?:'[a-z0-9]+)*")

    fun phrase(phrase: String): Map<String, Int> =
        wordPattern.findAll(phrase.lowercase())
            .map { it.value }
            .groupingBy { it }
            .eachCount()
}
