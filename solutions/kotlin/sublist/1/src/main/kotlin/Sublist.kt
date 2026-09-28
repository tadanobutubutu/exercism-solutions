enum class Relationship {
    EQUAL, SUBLIST, SUPERLIST, UNEQUAL
}

fun <T> List<T>.relationshipTo(other: List<T>): Relationship {
    if (this == other) return Relationship.EQUAL
    if (size < other.size && other.containsSubsequence(this)) return Relationship.SUBLIST
    if (size > other.size && containsSubsequence(other)) return Relationship.SUPERLIST
    return Relationship.UNEQUAL
}

private fun <T> List<T>.containsSubsequence(candidate: List<T>): Boolean {
    if (candidate.isEmpty()) return true
    if (candidate.size > size) return false
    return (0..size - candidate.size).any { start ->
        subList(start, start + candidate.size) == candidate
    }
}
