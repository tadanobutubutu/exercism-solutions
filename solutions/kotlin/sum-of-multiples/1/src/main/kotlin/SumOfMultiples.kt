object SumOfMultiples {

    fun sum(factors: Set<Int>, limit: Int): Int {
        return (1 until limit)
            .filter { number -> factors.any { factor -> factor != 0 && number % factor == 0 } }
            .sum()
    }
}
