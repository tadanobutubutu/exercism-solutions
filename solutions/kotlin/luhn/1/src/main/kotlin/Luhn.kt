object Luhn {
    fun isValid(candidate: String): Boolean {
        val digits = candidate.filterNot { it == ' ' }
        if (digits.length <= 1 || digits.any { it !in '0'..'9' }) return false

        val sum = digits.reversed().mapIndexed { index, character ->
            var value = character - '0'
            if (index % 2 == 1) {
                value *= 2
                if (value > 9) value -= 9
            }
            value
        }.sum()
        return sum % 10 == 0
    }
}
