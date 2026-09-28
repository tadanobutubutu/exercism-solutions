object Prime {
    fun nth(n: Int): Int {
        require(n > 0) { "There is no zeroth prime." }
        val primes = mutableListOf<Int>()
        var candidate = 2
        while (primes.size < n) {
            val isPrime = primes.takeWhile { it.toLong() * it <= candidate }
                .all { candidate % it != 0 }
            if (isPrime) primes.add(candidate)
            candidate = if (candidate == 2) 3 else candidate + 2
        }
        return primes.last()
    }
}
