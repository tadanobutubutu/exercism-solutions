object BottleSong {
    private val numberWords = listOf("no", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten")

    fun recite(startBottles: Int, takeDown: Int): String {
        if (takeDown <= 0 || startBottles <= 0) return ""
        return (startBottles downTo (startBottles - takeDown + 1)).joinToString("\n\n") { bottles ->
            val current = numberWords[bottles].replaceFirstChar { it.uppercase() }
            val remaining = numberWords[bottles - 1]
            val bottle = if (bottles == 1) "bottle" else "bottles"
            val remainingBottle = if (bottles - 1 == 1) "bottle" else "bottles"
            listOf(
                "$current green $bottle hanging on the wall,",
                "$current green $bottle hanging on the wall,",
                "And if one green bottle should accidentally fall,",
                "There'll be $remaining green $remainingBottle hanging on the wall."
            ).joinToString("\n")
        }
    }
}
