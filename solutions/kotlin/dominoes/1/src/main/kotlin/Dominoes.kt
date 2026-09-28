class ChainNotFoundException(msg: String) : RuntimeException(msg)

data class Domino(val left: Int, val right: Int)

object Dominoes {

    fun formChain(vararg inputDominoes: Domino): List<Domino> = formChain(inputDominoes.toList())

    fun formChain(inputDominoes: List<Domino>): List<Domino> {
        if (inputDominoes.isEmpty()) return emptyList()

        val adjacency = mutableMapOf<Int, MutableList<Int>>()
        val degrees = mutableMapOf<Int, Int>()
        inputDominoes.forEachIndexed { index, domino ->
            adjacency.getOrPut(domino.left) { mutableListOf() }.add(index)
            adjacency.getOrPut(domino.right) { mutableListOf() }.add(index)
            degrees[domino.left] = degrees.getOrDefault(domino.left, 0) + 1
            degrees[domino.right] = degrees.getOrDefault(domino.right, 0) + 1
        }
        if (degrees.values.any { it % 2 != 0 }) throw ChainNotFoundException("Dominoes cannot form a closed chain")

        val used = BooleanArray(inputDominoes.size)
        data class Step(val vertex: Int, val incoming: Domino?)
        val stack = ArrayDeque<Step>()
        stack.addLast(Step(inputDominoes.first().left, null))
        val reversedChain = mutableListOf<Domino>()

        while (stack.isNotEmpty()) {
            val vertex = stack.last().vertex
            val edgeIndex = adjacency[vertex]?.firstOrNull { !used[it] }
            if (edgeIndex == null) {
                stack.removeLast().incoming?.let(reversedChain::add)
            } else {
                used[edgeIndex] = true
                val domino = inputDominoes[edgeIndex]
                val next = if (domino.left == vertex) domino.right else domino.left
                stack.addLast(Step(next, Domino(vertex, next)))
            }
        }

        if (used.any { !it }) throw ChainNotFoundException("Dominoes are disconnected")
        return reversedChain.asReversed()
    }
}
