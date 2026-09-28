object Wordy {

    fun answer(input: String): Int {
        require(input.startsWith("What is ") && input.endsWith("?")) { "Invalid question" }
        val expression = input.removePrefix("What is ").removeSuffix("?").trim()
        val tokens = if (expression.isEmpty()) emptyList() else expression.split(Regex("\\s+"))
        require(tokens.isNotEmpty()) { "Missing number" }

        fun parseInteger(token: String): Int {
            require(token.matches(Regex("[+-]?\\d+"))) { "Expected a number" }
            return token.toInt()
        }

        var index = 0
        var result = parseInteger(tokens[index++])
        while (index < tokens.size) {
            when (tokens[index++]) {
                "plus" -> {
                    require(index < tokens.size) { "Missing operand" }
                    result += parseInteger(tokens[index++])
                }
                "minus" -> {
                    require(index < tokens.size) { "Missing operand" }
                    result -= parseInteger(tokens[index++])
                }
                "multiplied" -> {
                    require(index < tokens.size && tokens[index++] == "by") { "Invalid multiplication" }
                    require(index < tokens.size) { "Missing operand" }
                    result *= parseInteger(tokens[index++])
                }
                "divided" -> {
                    require(index < tokens.size && tokens[index++] == "by") { "Invalid division" }
                    require(index < tokens.size) { "Missing operand" }
                    result /= parseInteger(tokens[index++])
                }
                "raised" -> {
                    require(index < tokens.size && tokens[index++] == "to") { "Invalid exponentiation" }
                    require(index < tokens.size && tokens[index++] == "the") { "Invalid exponentiation" }
                    require(index < tokens.size) { "Missing exponent" }
                    val ordinal = tokens[index++]
                    require(ordinal.matches(Regex("\\d+(st|nd|rd|th)"))) { "Invalid exponent" }
                    val exponent = ordinal.replace(Regex("(st|nd|rd|th)$"), "").toInt()
                    require(index < tokens.size && tokens[index++] == "power") { "Invalid exponentiation" }
                    var base = result
                    var power = exponent
                    var value = 1
                    while (power > 0) {
                        if (power % 2 == 1) value *= base
                        base *= base
                        power /= 2
                    }
                    result = value
                }
                else -> throw IllegalArgumentException("Unsupported operation")
            }
        }
        return result
    }
}
