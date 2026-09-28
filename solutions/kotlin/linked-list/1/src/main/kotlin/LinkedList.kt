class Deque<T> {
    private class Node<T>(val value: T, var previous: Node<T>? = null, var next: Node<T>? = null)

    private var head: Node<T>? = null
    private var tail: Node<T>? = null

    fun push(value: T) {
        val node = Node(value, previous = tail)
        if (tail == null) head = node else tail?.next = node
        tail = node
    }

    fun pop(): T? {
        val node = tail ?: return null
        tail = node.previous
        if (tail == null) head = null else tail?.next = null
        return node.value
    }

    fun unshift(value: T) {
        val node = Node(value, next = head)
        if (head == null) tail = node else head?.previous = node
        head = node
    }

    fun shift(): T? {
        val node = head ?: return null
        head = node.next
        if (head == null) tail = null else head?.previous = null
        return node.value
    }
}
