class RotationalCipher(private val key: Int) {
    private val shift = Math.floorMod(key, 26)

    fun encode(text: String): String = text.map { character ->
        when (character) {
            in 'a'..'z' -> 'a' + (character - 'a' + shift) % 26
            in 'A'..'Z' -> 'A' + (character - 'A' + shift) % 26
            else -> character
        }
    }.joinToString("")
}
