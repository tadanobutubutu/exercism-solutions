class CustomSet(vararg values: Int) {
    private val elements = values.toMutableSet()

    fun isEmpty(): Boolean {
        return elements.isEmpty()
    }

    fun isSubset(other: CustomSet): Boolean {
        return elements.all { it in other.elements }
    }

    fun isDisjoint(other: CustomSet): Boolean {
        return elements.none { it in other.elements }
    }

    fun contains(other: Int): Boolean {
        return other in elements
    }

    fun intersection(other: CustomSet): CustomSet {
        return CustomSet(*elements.filter { it in other.elements }.toIntArray())
    }

    fun add(other: Int) {
        elements.add(other)
    }

    override fun equals(other: Any?): Boolean {
        return other is CustomSet && elements == other.elements
    }

    override fun hashCode(): Int = elements.hashCode()

    operator fun plus(other: CustomSet): CustomSet {
        return CustomSet(*(elements + other.elements).toIntArray())
    }

    operator fun minus(other: CustomSet): CustomSet {
        return CustomSet(*elements.filter { it !in other.elements }.toIntArray())
    }
}
