object ETL {
    fun transform(source: Map<Int, Collection<Char>>): Map<Char, Int> {
        return source.flatMap { (score, letters) ->
            letters.map { letter -> letter.lowercaseChar() to score }
        }.toMap()
    }
}
