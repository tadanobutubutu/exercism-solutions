object Atbash {
    fun encode(s: String): String = normalize(s)
        .map(::translate)
        .joinToString("")
        .chunked(5)
        .joinToString(" ")

    fun decode(s: String): String = normalize(s).map(::translate).joinToString("")

    private fun normalize(text: String): String = text.lowercase().filter {
        it in 'a'..'z' || it in '0'..'9'
    }

    private fun translate(character: Char): Char =
        if (character in 'a'..'z') 'z' - (character - 'a') else character
}
