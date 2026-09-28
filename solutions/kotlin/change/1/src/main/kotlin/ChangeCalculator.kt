class ChangeCalculator(private val coins: List<Int>) {

    fun computeMostEfficientChange(grandTotal: Int): List<Int> {
        require(grandTotal >= 0) { "Negative totals are not allowed." }
        if (grandTotal == 0) return emptyList()

        val usableCoins = coins.filter { it > 0 }.distinct()
        val bestCount = IntArray(grandTotal + 1) { Int.MAX_VALUE }
        val lastCoin = IntArray(grandTotal + 1)
        bestCount[0] = 0

        for (amount in 1..grandTotal) {
            for (coin in usableCoins) {
                if (coin <= amount && bestCount[amount - coin] != Int.MAX_VALUE) {
                    val candidate = bestCount[amount - coin] + 1
                    if (candidate < bestCount[amount]) {
                        bestCount[amount] = candidate
                        lastCoin[amount] = coin
                    }
                }
            }
        }

        if (bestCount[grandTotal] == Int.MAX_VALUE) {
            throw IllegalArgumentException("The total $grandTotal cannot be represented in the given currency.")
        }
        val change = mutableListOf<Int>()
        var remaining = grandTotal
        while (remaining > 0) {
            val coin = lastCoin[remaining]
            change.add(coin)
            remaining -= coin
        }
        return change.sorted()
    }
}
