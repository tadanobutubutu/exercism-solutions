class Squares(private val number: Int) {
    fun sumOfSquares(): Int = (1..number).sumOf { it * it }

    fun squareOfSum(): Int = (1..number).sum().let { it * it }

    fun difference(): Int = squareOfSum() - sumOfSquares()
}
