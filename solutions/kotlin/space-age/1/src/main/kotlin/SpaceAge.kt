class SpaceAge(private val seconds: Int) {
    private fun ageInEarthYears(): Double = seconds.toDouble() / SECONDS_PER_EARTH_YEAR

    fun onEarth(): Double = ageInEarthYears()
    fun onMercury(): Double = ageInEarthYears() / 0.2408467
    fun onVenus(): Double = ageInEarthYears() / 0.61519726
    fun onMars(): Double = ageInEarthYears() / 1.8808158
    fun onJupiter(): Double = ageInEarthYears() / 11.862615
    fun onSaturn(): Double = ageInEarthYears() / 29.447498
    fun onUranus(): Double = ageInEarthYears() / 84.016846
    fun onNeptune(): Double = ageInEarthYears() / 164.79132

    private companion object {
        const val SECONDS_PER_EARTH_YEAR = 31_557_600.0
    }
}
