class RailFenceCipher(private val rails: Int) {

    fun getEncryptedData(input: String): String {
        if (rails <= 1 || input.length <= 1) return input
        val rows = Array(rails) { StringBuilder() }
        railSequence(input.length).forEachIndexed { index, rail -> rows[rail].append(input[index]) }
        return rows.joinToString("")
    }

    fun getDecryptedData(input: String): String {
        if (rails <= 1 || input.length <= 1) return input
        val sequence = railSequence(input.length)
        val counts = IntArray(rails)
        sequence.forEach { counts[it]++ }

        val rows = Array(rails) { StringBuilder() }
        var offset = 0
        for (rail in 0 until rails) {
            repeat(counts[rail]) { rows[rail].append(input[offset++]) }
        }

        val positions = IntArray(rails)
        return buildString(input.length) {
            sequence.forEach { rail -> append(rows[rail][positions[rail]++]) }
        }
    }

    private fun railSequence(length: Int): List<Int> {
        if (rails <= 1) return List(length) { 0 }
        var rail = 0
        var direction = 1
        return List(length) {
            val current = rail
            if (rail == 0) direction = 1 else if (rail == rails - 1) direction = -1
            rail += direction
            current
        }
    }
}
