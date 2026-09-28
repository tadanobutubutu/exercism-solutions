object AffineCipher {
    private const val ALPHABET_SIZE = 26

    fun encode(input: String, a: Int, b: Int): String {
        validateKey(a)
        val transformed = normalize(input).map { character ->
            if (character in 'a'..'z') {
                val index = character - 'a'
                'a' + Math.floorMod(a.toLong() * index + b.toLong(), ALPHABET_SIZE.toLong()).toInt()
            } else character
        }.joinToString("")
        return transformed.chunked(5).joinToString(" ")
    }

    fun decode(input: String, a: Int, b: Int): String {
        validateKey(a)
        val inverse = (1 until ALPHABET_SIZE).first { Math.floorMod(a * it, ALPHABET_SIZE) == 1 }
        return normalize(input).map { character ->
            if (character in 'a'..'z') {
                val shifted = Math.floorMod((character - 'a') - b, ALPHABET_SIZE)
                'a' + Math.floorMod(inverse * shifted, ALPHABET_SIZE)
            } else character
        }.joinToString("")
    }

    private fun normalize(input: String): String = input.lowercase().filter {
        it in 'a'..'z' || it in '0'..'9'
    }

    private fun validateKey(a: Int) {
        require(gcd(a, ALPHABET_SIZE) == 1) { "a and m must be coprime." }
    }

    private fun gcd(first: Int, second: Int): Int {
        var a = kotlin.math.abs(first)
        var b = second
        while (b != 0) {
            val remainder = a % b
            a = b
            b = remainder
        }
        return a
    }
}
