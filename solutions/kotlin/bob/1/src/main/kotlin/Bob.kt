object Bob {
    fun hey(input: String): String {
        val message = input.trim()
        if (message.isEmpty()) return "Fine. Be that way!"

        val letters = message.filter(Char::isLetter)
        val isShouting = letters.isNotEmpty() && letters.all(Char::isUpperCase)
        val isQuestion = message.endsWith('?')

        return when {
            isShouting && isQuestion -> "Calm down, I know what I'm doing!"
            isShouting -> "Whoa, chill out!"
            isQuestion -> "Sure."
            else -> "Whatever."
        }
    }
}
