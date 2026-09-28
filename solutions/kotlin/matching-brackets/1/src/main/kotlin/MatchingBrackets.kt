object MatchingBrackets {

    fun isValid(input: String): Boolean {
        val expectedClosers = mapOf('(' to ')', '[' to ']', '{' to '}')
        val stack = ArrayDeque<Char>()
        for (character in input) {
            if (character in expectedClosers) {
                stack.addLast(expectedClosers.getValue(character))
            } else if (character == ')' || character == ']' || character == '}') {
                if (stack.isEmpty() || stack.removeLast() != character) return false
            }
        }
        return stack.isEmpty()
    }
}
