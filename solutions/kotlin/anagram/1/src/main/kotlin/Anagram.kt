class Anagram(source: String) {
    private val normalizedSource = source.lowercase()
    private val sortedSource = normalizedSource.toList().sorted()

    fun match(anagrams: Collection<String>): Set<String> {
        return anagrams.filterTo(mutableSetOf()) { candidate ->
            val normalizedCandidate = candidate.lowercase()
            normalizedCandidate != normalizedSource && normalizedCandidate.toList().sorted() == sortedSource
        }
    }
}
