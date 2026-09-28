public class CustomSet
{
    private readonly HashSet<int> values;

    public CustomSet(params int[] values)
    {
        ArgumentNullException.ThrowIfNull(values);
        this.values = new HashSet<int>(values);
    }

    public CustomSet Add(int value)
    {
        var result = new HashSet<int>(values) { value };
        return new CustomSet(result.ToArray());
    }

    public bool Empty()
    {
        return values.Count == 0;
    }

    public bool Contains(int value)
    {
        return values.Contains(value);
    }

    public bool Subset(CustomSet right)
    {
        ArgumentNullException.ThrowIfNull(right);
        return values.IsSubsetOf(right.values);
    }

    public bool Disjoint(CustomSet right)
    {
        ArgumentNullException.ThrowIfNull(right);
        return !values.Overlaps(right.values);
    }

    public CustomSet Intersection(CustomSet right)
    {
        ArgumentNullException.ThrowIfNull(right);
        return new CustomSet(values.Intersect(right.values).ToArray());
    }

    public CustomSet Difference(CustomSet right)
    {
        ArgumentNullException.ThrowIfNull(right);
        return new CustomSet(values.Except(right.values).ToArray());
    }

    public CustomSet Union(CustomSet right)
    {
        ArgumentNullException.ThrowIfNull(right);
        return new CustomSet(values.Union(right.values).ToArray());
    }

    public override bool Equals(object? obj) => obj is CustomSet other && values.SetEquals(other.values);

    public override int GetHashCode()
    {
        int hash = 0;
        foreach (int value in values) hash ^= value.GetHashCode();
        return hash;
    }
}
