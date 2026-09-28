public static class MatchingBrackets
{
    public static bool IsPaired(string input)
    {
        var expectedClosers = new Stack<char>();

        foreach (var character in input)
        {
            switch (character)
            {
                case '(':
                    expectedClosers.Push(')');
                    break;
                case '[':
                    expectedClosers.Push(']');
                    break;
                case '{':
                    expectedClosers.Push('}');
                    break;
                case ')':
                case ']':
                case '}':
                    if (expectedClosers.Count == 0 || expectedClosers.Pop() != character)
                    {
                        return false;
                    }

                    break;
            }
        }

        return expectedClosers.Count == 0;
    }
}
