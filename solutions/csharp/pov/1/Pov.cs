public class Tree
{
    public string Value { get; }
    public Tree[] Children { get; }

    public Tree(string value, params Tree[] children)
    {
        ArgumentNullException.ThrowIfNull(value);
        ArgumentNullException.ThrowIfNull(children);
        Value = value;
        Children = children;
    }

    public override bool Equals(object? obj) => obj is Tree other
        && Value == other.Value
        && Children.OrderBy(child => child.Value, StringComparer.Ordinal)
            .SequenceEqual(other.Children.OrderBy(child => child.Value, StringComparer.Ordinal));

    public override int GetHashCode()
    {
        int childrenHash = 0;
        foreach (Tree child in Children) childrenHash ^= child.GetHashCode();
        return HashCode.Combine(Value, childrenHash);
    }
}

public static class Pov
{
    public static Tree FromPov(Tree tree, string from)
    {
        ArgumentNullException.ThrowIfNull(tree);
        ArgumentNullException.ThrowIfNull(from);
        var graph = new Dictionary<string, List<string>>(StringComparer.Ordinal);
        BuildGraph(tree, graph);
        if (!graph.ContainsKey(from))
            throw new ArgumentException("The requested root was not found in the tree.", nameof(from));

        return BuildTree(from, null, graph);
    }

    private static void BuildGraph(Tree tree, Dictionary<string, List<string>> graph)
    {
        if (!graph.TryAdd(tree.Value, []))
            throw new ArgumentException("Tree node values must be unique.", nameof(tree));

        foreach (Tree child in tree.Children)
        {
            graph[tree.Value].Add(child.Value);
            BuildGraph(child, graph);
            graph[child.Value].Add(tree.Value);
        }
    }

    private static Tree BuildTree(string value, string? parent, Dictionary<string, List<string>> graph)
    {
        Tree[] children = graph[value]
            .Where(neighbor => neighbor != parent)
            .Select(neighbor => BuildTree(neighbor, value, graph))
            .ToArray();
        return new Tree(value, children);
    }

    public static IEnumerable<string> PathTo(string from, string to, Tree tree)
    {
        Tree rooted = FromPov(tree, from);
        var path = new List<string>();
        if (FindPath(rooted, to, path)) return path;
        throw new ArgumentException("The destination was not found in the tree.", nameof(to));
    }

    private static bool FindPath(Tree current, string target, List<string> path)
    {
        path.Add(current.Value);
        if (current.Value == target) return true;
        foreach (Tree child in current.Children)
        {
            if (FindPath(child, target, path)) return true;
        }
        path.RemoveAt(path.Count - 1);
        return false;
    }
}
