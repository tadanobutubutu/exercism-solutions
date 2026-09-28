class BaseConverter(private val sourceBase: Int, digits: IntArray) {
    private val sourceDigits = digits.copyOf()

    init {
        require(sourceBase >= 2) { "Bases must be at least 2." }
        require(sourceDigits.isNotEmpty()) { "You must supply at least one digit." }
        require(sourceDigits.size == 1 || sourceDigits[0] != 0) { "Digits may not contain leading zeros." }
        require(sourceDigits.all { it >= 0 }) { "Digits may not be negative." }
        require(sourceDigits.all { it < sourceBase }) { "All digits must be strictly less than the base." }
    }

    fun convertToBase(newBase: Int): IntArray {
        require(newBase >= 2) { "Bases must be at least 2." }
        if (sourceDigits.all { it == 0 }) return intArrayOf(0)

        var current = sourceDigits.toList()
        val resultReversed = mutableListOf<Int>()
        while (current.any { it != 0 }) {
            var carry = 0L
            val quotient = mutableListOf<Int>()
            for (digit in current) {
                val value = carry * sourceBase + digit
                val quotientDigit = (value / newBase).toInt()
                carry = value % newBase
                if (quotient.isNotEmpty() || quotientDigit != 0) quotient.add(quotientDigit)
            }
            resultReversed.add(carry.toInt())
            current = quotient
        }
        return resultReversed.asReversed().toIntArray()
    }
}
