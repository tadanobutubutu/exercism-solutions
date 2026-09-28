object Flattener {
    fun flatten(source: Collection<Any?>): List<Any> {
        val result = mutableListOf<Any>()

        fun visit(value: Any?) {
            when (value) {
                null -> Unit
                is Collection<*> -> value.forEach(::visit)
                else -> result.add(value)
            }
        }

        source.forEach(::visit)
        return result
    }
}
