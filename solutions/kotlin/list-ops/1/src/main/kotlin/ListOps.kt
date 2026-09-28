fun <T> List<T>.customAppend(list: List<T>): List<T> {
    val result = mutableListOf<T>()
    for (item in this) result.add(item)
    for (item in list) result.add(item)
    return result
}

fun List<Any>.customConcat(): List<Any> {
    val result = mutableListOf<Any>()
    fun addFlattened(value: Any) {
        if (value is Iterable<*>) {
            for (item in value) if (item != null) addFlattened(item)
        } else {
            result.add(value)
        }
    }
    for (item in this) addFlattened(item)
    return result
}

fun <T> List<T>.customFilter(predicate: (T) -> Boolean): List<T> {
    val result = mutableListOf<T>()
    for (item in this) if (predicate(item)) result.add(item)
    return result
}

val List<Any>.customSize: Int
    get() {
        var count = 0
        for (ignored in this) count++
        return count
    }

fun <T, U> List<T>.customMap(transform: (T) -> U): List<U> {
    val result = mutableListOf<U>()
    for (item in this) result.add(transform(item))
    return result
}

fun <T, U> List<T>.customFoldLeft(initial: U, f: (U, T) -> U): U {
    var accumulator = initial
    for (item in this) accumulator = f(accumulator, item)
    return accumulator
}

fun <T, U> List<T>.customFoldRight(initial: U, f: (T, U) -> U): U {
    var accumulator = initial
    var index = lastIndex
    while (index >= 0) {
        accumulator = f(this[index], accumulator)
        index--
    }
    return accumulator
}

fun <T> List<T>.customReverse(): List<T> {
    val result = mutableListOf<T>()
    var index = lastIndex
    while (index >= 0) {
        result.add(this[index])
        index--
    }
    return result
}
