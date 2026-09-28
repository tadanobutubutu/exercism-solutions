data class Item(val weight: Int, val value: Int)

fun knapsack(maximumWeight: Int, items: List<Item>): Int {
    if (maximumWeight < 0) return 0
    val bestValue = IntArray(maximumWeight + 1)
    for (item in items) {
        for (capacity in maximumWeight downTo item.weight) {
            bestValue[capacity] = maxOf(bestValue[capacity], bestValue[capacity - item.weight] + item.value)
        }
    }
    return bestValue[maximumWeight]
}
