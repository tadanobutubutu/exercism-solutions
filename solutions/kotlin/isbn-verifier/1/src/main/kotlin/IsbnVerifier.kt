class IsbnVerifier {
    fun isValid(number: String): Boolean {
        val isbn = number.filterNot { it == '-' }
        if (isbn.length != 10) return false
        val values = isbn.mapIndexed { index, character ->
            when {
                character in '0'..'9' -> character - '0'
                index == 9 && character == 'X' -> 10
                else -> return false
            }
        }
        return values.mapIndexed { index, value -> value * (10 - index) }.sum() % 11 == 0
    }
}
