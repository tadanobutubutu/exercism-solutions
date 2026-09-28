object ResistorColorTrio {

    fun text(vararg input: Color): String {
        require(input.size >= 3) { "Three color bands are required" }
        val units = listOf("ohms", "kiloohms", "megaohms", "gigaohms", "teraohms", "petaohms", "exaohms")
        var value = (input[0].ordinal * 10L + input[1].ordinal) *
            (1L..input[2].ordinal).fold(1L) { product, _ -> product * 10L }
        var unitIndex = 0
        while (value != 0L && value % 1000L == 0L && unitIndex < units.lastIndex) {
            value /= 1000L
            unitIndex++
        }
        return "$value ${units[unitIndex]}"
    }
}
