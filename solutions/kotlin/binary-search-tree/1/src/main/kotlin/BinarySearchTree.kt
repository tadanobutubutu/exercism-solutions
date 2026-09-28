class BinarySearchTree<T : Comparable<T>> {

    data class Node<T>(val data: T, var left: Node<T>? = null, var right: Node<T>? = null)

    var root: Node<T>? = null

    fun insert(value: T) {
        val currentRoot = root
        if (currentRoot == null) {
            root = Node(value)
            return
        }

        var current: Node<T> = currentRoot
        while (true) {
            if (value <= current.data) {
                val left = current.left
                if (left == null) {
                    current.left = Node(value)
                    return
                }
                current = left
            } else {
                val right = current.right
                if (right == null) {
                    current.right = Node(value)
                    return
                }
                current = right
            }
        }
    }

    fun asSortedList(): List<T> {
        val result = mutableListOf<T>()
        fun visit(node: Node<T>?) {
            if (node == null) return
            visit(node.left)
            result.add(node.data)
            visit(node.right)
        }
        visit(root)
        return result
    }

    fun asLevelOrderList(): List<T> {
        val result = mutableListOf<T>()
        val queue = ArrayDeque<Node<T>>()
        root?.let(queue::addLast)
        while (queue.isNotEmpty()) {
            val node = queue.removeFirst()
            result.add(node.data)
            node.left?.let(queue::addLast)
            node.right?.let(queue::addLast)
        }
        return result
    }

}
