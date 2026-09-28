object Pangram {

    fun isPangram(input: String): Boolean {
        val letters = input.lowercase().toSet()
        return ('a'..'z').all { it in letters }
    }
}
