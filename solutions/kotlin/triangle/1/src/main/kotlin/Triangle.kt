class Triangle<out T : Number>(val a: T, val b: T, val c: T) {
    private val sides = listOf(a.toDouble(), b.toDouble(), c.toDouble())

    init {
        require(sides.all { it.isFinite() && it > 0.0 })
        val sortedSides = sides.sorted()
        require(sortedSides[0] + sortedSides[1] > sortedSides[2])
    }

    val isEquilateral: Boolean = sides.distinct().size == 1
    val isIsosceles: Boolean = sides[0] == sides[1] || sides[1] == sides[2] || sides[0] == sides[2]
    val isScalene: Boolean = !isIsosceles
}
