using System.Globalization;

public static class Forth
{
    public static string Evaluate(string[] instructions)
    {
        var stack = new Stack<int>();
        var userWords = new Dictionary<string, Action<Stack<int>>>(StringComparer.OrdinalIgnoreCase);
        var tokens = string.Join(' ', instructions).Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries);

        for (var index = 0; index < tokens.Length; index++)
        {
            if (tokens[index] != ":")
            {
                Execute(tokens[index], stack, userWords);
                continue;
            }

            if (++index >= tokens.Length)
            {
                throw new InvalidOperationException("A word definition requires a name.");
            }

            var name = tokens[index].ToLowerInvariant();
            if (int.TryParse(name, NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out _))
            {
                throw new InvalidOperationException("A number cannot be redefined.");
            }

            var body = new List<Action<Stack<int>>>();
            var ended = false;
            while (++index < tokens.Length)
            {
                if (tokens[index] == ";")
                {
                    ended = true;
                    break;
                }

                body.Add(Compile(tokens[index], userWords));
            }

            if (!ended)
            {
                throw new InvalidOperationException("A word definition must end with ';'.");
            }

            var compiledBody = body.ToArray();
            userWords[name] = values =>
            {
                foreach (var operation in compiledBody)
                {
                    operation(values);
                }
            };
        }

        return string.Join(' ', stack.Reverse());
    }

    private static void Execute(string token, Stack<int> stack, Dictionary<string, Action<Stack<int>>> userWords)
        => Compile(token, userWords)(stack);

    private static Action<Stack<int>> Compile(string token, Dictionary<string, Action<Stack<int>>> userWords)
    {
        if (int.TryParse(token, NumberStyles.AllowLeadingSign, CultureInfo.InvariantCulture, out var number))
        {
            return stack => stack.Push(number);
        }

        if (userWords.TryGetValue(token, out var userWord))
        {
            return userWord;
        }

        return token.ToLowerInvariant() switch
        {
            "+" => Binary((left, right) => left + right),
            "-" => Binary((left, right) => left - right),
            "*" => Binary((left, right) => left * right),
            "/" => Binary((left, right) => left / right),
            "dup" => stack => { Require(stack, 1); stack.Push(stack.Peek()); },
            "drop" => stack => { Require(stack, 1); stack.Pop(); },
            "swap" => stack => { Require(stack, 2); var first = stack.Pop(); var second = stack.Pop(); stack.Push(first); stack.Push(second); },
            "over" => stack => { Require(stack, 2); var top = stack.Pop(); var below = stack.Peek(); stack.Push(top); stack.Push(below); },
            _ => throw new InvalidOperationException($"Unknown word: {token}")
        };
    }

    private static Action<Stack<int>> Binary(Func<int, int, int> operation) => stack =>
    {
        Require(stack, 2);
        var right = stack.Pop();
        var left = stack.Pop();
        stack.Push(operation(left, right));
    };

    private static void Require(Stack<int> stack, int count)
    {
        if (stack.Count < count)
        {
            throw new InvalidOperationException("The stack does not contain enough values.");
        }
    }
}
