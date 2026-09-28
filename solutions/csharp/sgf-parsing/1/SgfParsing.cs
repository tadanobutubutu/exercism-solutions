using System.Text;

public class SgfTree
{
    public SgfTree(IDictionary<string, string[]> data, params SgfTree[] children)
    {
        Data = data;
        Children = children;
    }

    public IDictionary<string, string[]> Data { get; }
    public SgfTree[] Children { get; }
}

public class SgfParser
{
    public static SgfTree ParseTree(string input)
    {
        if (string.IsNullOrEmpty(input)) throw new ArgumentException("Input must contain a tree.", nameof(input));
        var parser = new Parser(input);
        var root = parser.ParseGameTree();
        if (!parser.AtEnd) throw new ArgumentException("Unexpected input after the tree.", nameof(input));
        return root.ToSgfTree();
    }

    private sealed class Node
    {
        public Dictionary<string, string[]> Data { get; } = new();
        public List<Node> Children { get; } = [];

        public SgfTree ToSgfTree() => new(Data, Children.Select(child => child.ToSgfTree()).ToArray());
    }

    private sealed class Parser(string input)
    {
        private int position;
        public bool AtEnd => position == input.Length;

        public Node ParseGameTree()
        {
            Expect('(');
            var sequence = new List<Node>();
            while (Peek() == ';') sequence.Add(ParseNode());
            if (sequence.Count == 0) throw new ArgumentException("A game tree must contain at least one node.");

            for (var i = 1; i < sequence.Count; i++) sequence[i - 1].Children.Add(sequence[i]);
            while (Peek() == '(') sequence[^1].Children.Add(ParseGameTree());
            Expect(')');
            return sequence[0];
        }

        private Node ParseNode()
        {
            Expect(';');
            var node = new Node();
            while (IsUpper(Peek()))
            {
                var keyStart = position;
                while (IsUpper(Peek())) position++;
                var key = input[keyStart..position];
                if (node.Data.ContainsKey(key) || Peek() != '[') throw new ArgumentException("Invalid SGF property.");

                var values = new List<string>();
                while (Peek() == '[') values.Add(ParseValue());
                node.Data.Add(key, values.ToArray());
            }

            return node;
        }

        private string ParseValue()
        {
            Expect('[');
            var value = new StringBuilder();
            while (position < input.Length)
            {
                var character = input[position++];
                if (character == ']') return value.ToString();

                if (character == '\\')
                {
                    if (position >= input.Length) throw new ArgumentException("Unterminated escape sequence.");
                    var escaped = input[position++];
                    if (escaped == '\n') continue;
                    value.Append(char.IsWhiteSpace(escaped) ? ' ' : escaped);
                }
                else
                {
                    value.Append(character != '\n' && char.IsWhiteSpace(character) ? ' ' : character);
                }
            }

            throw new ArgumentException("Unterminated property value.");
        }

        private char Peek() => position < input.Length ? input[position] : '\0';

        private void Expect(char expected)
        {
            if (Peek() != expected) throw new ArgumentException($"Expected '{expected}'.");
            position++;
        }

        private static bool IsUpper(char character) => character is >= 'A' and <= 'Z';
    }
}
