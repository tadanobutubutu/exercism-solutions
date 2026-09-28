object BinarySearch {
    fun search(list: List<Int>, item: Int): Int {
        var low = 0
        var high = list.lastIndex
        while (low <= high) {
            val mid = low + (high - low) / 2
            when {
                list[mid] == item -> return mid
                list[mid] < item -> low = mid + 1
                else -> high = mid - 1
            }
        }
        throw NoSuchElementException("$item is not in the list")
    }
}
