class Forth {
    private sealed class Operation {
        data class Push(val value: Int) : Operation()
        object Add : Operation()
        object Subtract : Operation()
        object Multiply : Operation()
        object Divide : Operation()
        object Duplicate : Operation()
        object Drop : Operation()
        object Swap : Operation()
        object Over : Operation()
    }

    fun evaluate(vararg line: String): List<Int> {
        val definitions = mutableMapOf<String, List<Operation>>()
        definitions["+"] = listOf(Operation.Add)
        definitions["-"] = listOf(Operation.Subtract)
        definitions["*"] = listOf(Operation.Multiply)
        definitions["/"] = listOf(Operation.Divide)
        definitions["dup"] = listOf(Operation.Duplicate)
        definitions["drop"] = listOf(Operation.Drop)
        definitions["swap"] = listOf(Operation.Swap)
        definitions["over"] = listOf(Operation.Over)

        val tokens = line.flatMap { it.trim().split(Regex("\\s+")).filter(String::isNotEmpty) }
        val stack = mutableListOf<Int>()
        var index = 0

        fun compile(token: String): List<Operation> {
            val number = token.toIntOrNull()
            if (number != null) return listOf(Operation.Push(number))
            return definitions[token.lowercase()] ?: throw IllegalArgumentException("undefined operation")
        }

        fun execute(operation: Operation) {
            when (operation) {
                is Operation.Push -> stack.add(operation.value)
                Operation.Add, Operation.Subtract, Operation.Multiply, Operation.Divide -> {
                    if (stack.isEmpty()) throw IllegalArgumentException("empty stack")
                    if (stack.size == 1) throw IllegalArgumentException("only one value on the stack")
                    val right = stack.removeAt(stack.lastIndex)
                    val left = stack.removeAt(stack.lastIndex)
                    val result = when (operation) {
                        Operation.Add -> left + right
                        Operation.Subtract -> left - right
                        Operation.Multiply -> left * right
                        Operation.Divide -> {
                            if (right == 0) throw IllegalArgumentException("divide by zero")
                            left / right
                        }
                        else -> error("Unexpected arithmetic operation")
                    }
                    stack.add(result)
                }
                Operation.Duplicate -> {
                    if (stack.isEmpty()) throw IllegalArgumentException("empty stack")
                    stack.add(stack.last())
                }
                Operation.Drop -> {
                    if (stack.isEmpty()) throw IllegalArgumentException("empty stack")
                    stack.removeAt(stack.lastIndex)
                }
                Operation.Swap -> {
                    if (stack.isEmpty()) throw IllegalArgumentException("empty stack")
                    if (stack.size == 1) throw IllegalArgumentException("only one value on the stack")
                    val top = stack.removeAt(stack.lastIndex)
                    val below = stack.removeAt(stack.lastIndex)
                    stack.add(top)
                    stack.add(below)
                }
                Operation.Over -> {
                    if (stack.isEmpty()) throw IllegalArgumentException("empty stack")
                    if (stack.size == 1) throw IllegalArgumentException("only one value on the stack")
                    stack.add(stack[stack.lastIndex - 1])
                }
            }
        }

        while (index < tokens.size) {
            val token = tokens[index]
            if (token == ":") {
                if (index + 1 >= tokens.size) throw IllegalArgumentException("illegal operation")
                val name = tokens[index + 1]
                if (name == ":" || name == ";" || name.toIntOrNull() != null) {
                    throw IllegalArgumentException("illegal operation")
                }
                index += 2
                val body = mutableListOf<Operation>()
                while (index < tokens.size && tokens[index] != ";") {
                    body.addAll(compile(tokens[index]))
                    index++
                }
                if (index >= tokens.size) throw IllegalArgumentException("illegal operation")
                definitions[name.lowercase()] = body
                index++
            } else {
                compile(token).forEach(::execute)
                index++
            }
        }
        return stack.toList()
    }
}
