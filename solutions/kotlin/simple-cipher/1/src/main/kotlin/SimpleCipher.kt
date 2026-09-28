import java.security.SecureRandom

class Cipher(key: String? = null) {
    val key: String = key ?: generateKey()

    init {
        require(this.key.isNotEmpty() && this.key.all { it in 'a'..'z' }) {
            "Key must contain lowercase letters only"
        }
    }

    fun encode(s: String): String {
        return transform(s, encode = true)
    }

    fun decode(s: String): String {
        return transform(s, encode = false)
    }

    private fun transform(input: String, encode: Boolean): String = buildString(input.length) {
        var keyPosition = 0
        input.forEach { character ->
            if (character in 'a'..'z') {
                val shift = key[keyPosition % key.length] - 'a'
                val offset = character - 'a'
                val transformed = if (encode) (offset + shift) % 26 else (offset - shift + 26) % 26
                append(('a'.code + transformed).toChar())
                keyPosition++
            } else {
                append(character)
            }
        }
    }

    companion object {
        private val random = SecureRandom()

        private fun generateKey(): String = buildString(100) {
            repeat(100) { append(('a'.code + random.nextInt(26)).toChar()) }
        }
    }
}
