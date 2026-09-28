public class BinTree
{
    public BinTree(int value, BinTree? left, BinTree? right)
    {
        Value = value;
        Left = left;
        Right = right;
    }

    public int Value { get; }
    public BinTree? Left { get; }
    public BinTree? Right { get; }

    public override bool Equals(object? obj) => obj is BinTree other
        && Value == other.Value
        && Equals(Left, other.Left)
        && Equals(Right, other.Right);

    public override int GetHashCode() => HashCode.Combine(Value, Left, Right);
}

public class Zipper
{
    private readonly BinTree root;
    private readonly string path;

    private Zipper(BinTree root, string path)
    {
        this.root = root;
        this.path = path;
    }

    public int Value()
    {
        return Focus().Value;
    }

    public Zipper SetValue(int newValue)
    {
        BinTree focus = Focus();
        var replacement = new BinTree(newValue, focus.Left, focus.Right);
        return new Zipper(ReplaceAt(root, path, replacement), path);
    }

    public Zipper SetLeft(BinTree? binTree)
    {
        BinTree focus = Focus();
        var replacement = new BinTree(focus.Value, binTree, focus.Right);
        return new Zipper(ReplaceAt(root, path, replacement), path);
    }

    public Zipper SetRight(BinTree? binTree) 
    {
        BinTree focus = Focus();
        var replacement = new BinTree(focus.Value, focus.Left, binTree);
        return new Zipper(ReplaceAt(root, path, replacement), path);
    }

    public Zipper? Left()
    {
        return Focus().Left is null ? null : new Zipper(root, path + 'L');
    }

    public Zipper? Right()
    {
        return Focus().Right is null ? null : new Zipper(root, path + 'R');
    }

    public Zipper? Up()
    {
        return path.Length == 0 ? null : new Zipper(root, path[..^1]);
    }

    public BinTree ToTree()
    {
        return root;
    }

    public static Zipper FromTree(BinTree tree)
    {
        ArgumentNullException.ThrowIfNull(tree);
        return new Zipper(tree, string.Empty);
    }

    public override bool Equals(object? obj) => obj is Zipper other && path == other.path && root.Equals(other.root);

    public override int GetHashCode() => HashCode.Combine(root, path);

    private BinTree Focus()
    {
        BinTree current = root;
        foreach (char step in path)
        {
            current = step == 'L' ? current.Left! : current.Right!;
        }
        return current;
    }

    private static BinTree ReplaceAt(BinTree tree, string remainingPath, BinTree replacement)
    {
        if (remainingPath.Length == 0) return replacement;
        char step = remainingPath[0];
        if (step == 'L')
        {
            return new BinTree(tree.Value, ReplaceAt(tree.Left!, remainingPath[1..], replacement), tree.Right);
        }
        return new BinTree(tree.Value, tree.Left, ReplaceAt(tree.Right!, remainingPath[1..], replacement));
    }
}
