object PrimeFactorCalculator {

    fun primeFactors(int: Int): List<Int> {
        return factorize(int.toLong()).map(Long::toInt)
    }

    fun primeFactors(long: Long): List<Long> {
        return factorize(long)
    }

    private fun factorize(number: Long): List<Long> {
        require(number > 0) { "Number must be positive" }
        var remaining = number
        var candidate = 2L
        val factors = mutableListOf<Long>()
        while (candidate <= remaining / candidate) {
            while (remaining % candidate == 0L) {
                factors.add(candidate)
                remaining /= candidate
            }
            candidate++
        }
        if (remaining > 1L) factors.add(remaining)
        return factors
    }
}
