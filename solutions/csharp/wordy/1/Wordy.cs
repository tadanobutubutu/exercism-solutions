public static class Wordy
{
    public static int Answer(string question)
    {
        const string prefix = "What is ";
        if (!question.StartsWith(prefix, StringComparison.Ordinal) || !question.EndsWith('?'))
        {
            throw new ArgumentException("Invalid question.", nameof(question));
        }

        var tokens = question[prefix.Length..^1].Split(' ', StringSplitOptions.RemoveEmptyEntries);
        if (tokens.Length == 0 || !int.TryParse(tokens[0], out var answer))
        {
            throw new ArgumentException("Invalid question.", nameof(question));
        }

        var index = 1;
        while (index < tokens.Length)
        {
            var operation = tokens[index++];
            if (operation is "multiplied" or "divided")
            {
                if (index >= tokens.Length || tokens[index++] != "by") throw new ArgumentException("Invalid operation.", nameof(question));
            }

            if (index >= tokens.Length || !int.TryParse(tokens[index++], out var operand))
            {
                throw new ArgumentException("Invalid operand.", nameof(question));
            }

            answer = operation switch
            {
                "plus" => answer + operand,
                "minus" => answer - operand,
                "multiplied" => answer * operand,
                "divided" => answer / operand,
                _ => throw new ArgumentException("Unsupported operation.", nameof(question))
            };
        }

        return answer;
    }
}
