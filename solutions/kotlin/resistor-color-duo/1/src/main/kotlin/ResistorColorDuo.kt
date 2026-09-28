object ResistorColorDuo {

    fun value(vararg colors: Color): Int {
        require(colors.size >= 2) { "At least two colors are required" }
        return colors[0].ordinal * 10 + colors[1].ordinal
    }
}
