object RunLengthEncoding {

    fun encode(input: String): String {
        if (input.isEmpty()) return ""
        val encoded = StringBuilder()
        var runStart = 0
        for (index in 1..input.length) {
            if (index == input.length || input[index] != input[runStart]) {
                val count = index - runStart
                if (count > 1) encoded.append(count)
                encoded.append(input[runStart])
                runStart = index
            }
        }
        return encoded.toString()
    }

    fun decode(input: String): String {
        val decoded = StringBuilder()
        var count = 0
        for (character in input) {
            if (character.isDigit()) {
                count = count * 10 + character.digitToInt()
            } else {
                decoded.append(character.toString().repeat(if (count == 0) 1 else count))
                count = 0
            }
        }
        return decoded.toString()
    }
}
