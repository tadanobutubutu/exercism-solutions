object Sieve {

    fun primesUpTo(upperBound: Int): List<Int> {
        if (upperBound < 2) return emptyList()
        val isPrime = BooleanArray(upperBound + 1) { true }
        isPrime[0] = false
        isPrime[1] = false
        var prime = 2
        while (prime <= upperBound / prime) {
            if (isPrime[prime]) {
                var multiple = prime * prime
                while (multiple <= upperBound) {
                    isPrime[multiple] = false
                    multiple += prime
                }
            }
            prime++
        }
        return isPrime.indices.filter { isPrime[it] }
    }
}
