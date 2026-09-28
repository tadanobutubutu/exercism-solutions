using System.Collections;

public class Node
    : Element
{
    public Node(string name) => Name = name;
    public string Name { get; }

    public override bool Equals(object? obj) => obj is Node other && Name == other.Name;
    public override int GetHashCode() => Name.GetHashCode(StringComparison.Ordinal);
}

public class Edge : Element
{
    public Edge(string node1, string node2)
    {
        Node1 = node1;
        Node2 = node2;
    }

    public string Node1 { get; }
    public string Node2 { get; }

    public override bool Equals(object? obj) => obj is Edge other && Node1 == other.Node1 && Node2 == other.Node2;
    public override int GetHashCode() => HashCode.Combine(Node1, Node2);
}

public class Attr
{
    public Attr(string key, string value)
    {
        Key = key;
        Value = value;
    }

    public string Key { get; }
    public string Value { get; }

    public override bool Equals(object? obj) => obj is Attr other && Key == other.Key && Value == other.Value;
    public override int GetHashCode() => HashCode.Combine(Key, Value);
}

public abstract class Element : IEnumerable<Attr>
{
    protected readonly List<Attr> attributes = [];

    public void Add(string key, string value) => attributes.Add(new Attr(key, value));
    public IEnumerator<Attr> GetEnumerator() => attributes.GetEnumerator();
    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}

public class Graph : Element
{
    private readonly List<Node> nodes = [];
    private readonly List<Edge> edges = [];

    public IEnumerable<Node> Nodes => nodes;
    public IEnumerable<Edge> Edges => edges;
    public IEnumerable<Attr> Attrs => attributes;

    public void Add(Node node) => nodes.Add(node);
    public void Add(Edge edge) => edges.Add(edge);
}
