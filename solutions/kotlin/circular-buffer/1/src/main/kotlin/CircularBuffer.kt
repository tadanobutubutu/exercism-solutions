import kotlin.collections.ArrayDeque

class EmptyBufferException : Exception()

class BufferFullException : Exception()

class CircularBuffer<T>(private val capacity: Int) {
    private val values = ArrayDeque<T>()

    fun read(): T {
        if (values.isEmpty()) throw EmptyBufferException()
        return values.removeFirst()
    }

    fun write(value: T) {
        if (values.size >= capacity) throw BufferFullException()
        values.addLast(value)
    }

    fun overwrite(value: T) {
        if (values.size >= capacity) values.removeFirst()
        values.addLast(value)
    }

    fun clear() {
        values.clear()
    }
}
