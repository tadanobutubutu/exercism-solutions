class NumberSpeller {
    private val smallNumbers = listOf(
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen",
        "eighteen", "nineteen"
    )
    private val tens = listOf("", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety")

    fun say(input: Long): String {
        require(input in 0..999_999_999_999L) { "Number is outside the supported range" }
        if (input == 0L) return "zero"

        val groups = listOf(
            1_000_000_000L to "billion",
            1_000_000L to "million",
            1_000L to "thousand",
            1L to ""
        )
        var remaining = input
        val parts = mutableListOf<String>()
        for ((place, label) in groups) {
            val group = (remaining / place).toInt()
            if (group > 0) {
                val words = sayUnderOneThousand(group)
                parts.add(if (label.isEmpty()) words else "$words $label")
                remaining %= place
            }
        }
        return parts.joinToString(" ")
    }

    private fun sayUnderOneThousand(number: Int): String {
        val parts = mutableListOf<String>()
        var remaining = number
        if (remaining >= 100) {
            parts.add("${smallNumbers[remaining / 100]} hundred")
            remaining %= 100
        }
        when {
            remaining >= 20 -> {
                val tensWord = tens[remaining / 10]
                val ones = remaining % 10
                parts.add(if (ones == 0) tensWord else "$tensWord-${smallNumbers[ones]}")
            }
            remaining > 0 -> parts.add(smallNumbers[remaining])
        }
        return parts.joinToString(" ")
    }
}
