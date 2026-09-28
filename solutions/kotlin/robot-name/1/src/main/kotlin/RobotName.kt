import java.security.SecureRandom

class Robot {
    private var currentName = generateUniqueName()

    val name: String
        get() = currentName

    fun reset() {
        currentName = generateUniqueName()
    }

    companion object {
        private val random = SecureRandom()
        private val usedNames = HashSet<String>()

        private fun generateUniqueName(): String = synchronized(usedNames) {
            while (true) {
                val value = random.nextInt(676_000)
                val name = buildString {
                    append(('A'.code + value / 26_000).toChar())
                    append(('A'.code + (value / 1_000) % 26).toChar())
                    append((value % 1_000).toString().padStart(3, '0'))
                }
                if (usedNames.add(name)) return@synchronized name
            }
            error("All robot names are exhausted")
        }
    }
}
