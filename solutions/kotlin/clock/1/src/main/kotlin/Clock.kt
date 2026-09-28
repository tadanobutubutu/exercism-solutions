class Clock(hours: Int, minutes: Int) {
    private var minutesSinceMidnight: Long = normalize(hours.toLong() * 60L + minutes.toLong())

    fun subtract(minutes: Int) {
        minutesSinceMidnight = normalize(minutesSinceMidnight - minutes.toLong())
    }

    fun add(minutes: Int) {
        minutesSinceMidnight = normalize(minutesSinceMidnight + minutes.toLong())
    }

    override fun toString(): String {
        val hour = minutesSinceMidnight / 60
        val minute = minutesSinceMidnight % 60
        return "%02d:%02d".format(hour, minute)
    }

    override fun equals(other: Any?): Boolean =
        other is Clock && minutesSinceMidnight == other.minutesSinceMidnight

    override fun hashCode(): Int = minutesSinceMidnight.hashCode()

    private fun normalize(minutes: Long): Long = Math.floorMod(minutes, MINUTES_PER_DAY)

    private companion object {
        const val MINUTES_PER_DAY = 24L * 60L
    }
}
