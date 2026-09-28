object Yacht {
    fun solve(category: YachtCategory, vararg dices: Int): Int {
        val counts = dices.toList().groupingBy { it }.eachCount()
        val total = dices.sum()
        return when (category) {
            YachtCategory.YACHT -> if (counts.size == 1 && dices.size == 5) 50 else 0
            YachtCategory.ONES -> dices.count { it == 1 }
            YachtCategory.TWOS -> dices.count { it == 2 } * 2
            YachtCategory.THREES -> dices.count { it == 3 } * 3
            YachtCategory.FOURS -> dices.count { it == 4 } * 4
            YachtCategory.FIVES -> dices.count { it == 5 } * 5
            YachtCategory.SIXES -> dices.count { it == 6 } * 6
            YachtCategory.FULL_HOUSE -> if (counts.values.sorted() == listOf(2, 3)) total else 0
            YachtCategory.FOUR_OF_A_KIND -> {
                val four = counts.entries.firstOrNull { it.value >= 4 }
                four?.key?.times(4) ?: 0
            }
            YachtCategory.LITTLE_STRAIGHT -> if (dices.toSet() == setOf(1, 2, 3, 4, 5) && dices.size == 5) 30 else 0
            YachtCategory.BIG_STRAIGHT -> if (dices.toSet() == setOf(2, 3, 4, 5, 6) && dices.size == 5) 30 else 0
            YachtCategory.CHOICE -> total
        }
    }
}
