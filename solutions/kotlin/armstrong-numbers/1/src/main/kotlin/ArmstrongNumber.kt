object ArmstrongNumber {

    fun check(input: Int): Boolean {
        if (input < 0) return false
        val digits = input.toString()
        val exponent = digits.length
        val sum = digits.fold(0L) { total, character ->
            val digit = character.digitToInt().toLong()
            val power = (0 until exponent).fold(1L) { result, _ -> result * digit }
            total + power
        }
        return sum == input.toLong()
    }

}
