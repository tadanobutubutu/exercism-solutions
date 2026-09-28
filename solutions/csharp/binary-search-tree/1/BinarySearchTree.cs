using System.Collections;

public class BinarySearchTree : IEnumerable<int>
{
    private readonly int value;
    private BinarySearchTree? left;
    private BinarySearchTree? right;

    public BinarySearchTree(int value)
    {
        this.value = value;
    }

    public BinarySearchTree(IEnumerable<int> values)
    {
        using var enumerator = values.GetEnumerator();
        if (!enumerator.MoveNext()) throw new ArgumentException("A tree requires a root value.", nameof(values));
        value = enumerator.Current;
        while (enumerator.MoveNext()) Add(enumerator.Current);
    }

    public int Value
    {
        get
        {
            return value;
        }
    }

    public BinarySearchTree? Left
    {
        get
        {
            return left;
        }
    }

    public BinarySearchTree? Right
    {
        get
        {
            return right;
        }
    }

    public BinarySearchTree Add(int value)
    {
        if (value <= this.value)
        {
            if (left is null) left = new BinarySearchTree(value);
            else left.Add(value);
        }
        else
        {
            if (right is null) right = new BinarySearchTree(value);
            else right.Add(value);
        }

        return this;
    }

    public IEnumerator<int> GetEnumerator()
    {
        if (left is not null)
        {
            foreach (var item in left) yield return item;
        }

        yield return value;

        if (right is not null)
        {
            foreach (var item in right) yield return item;
        }
    }

    IEnumerator IEnumerable.GetEnumerator()
    {
        return GetEnumerator();
    }
}
