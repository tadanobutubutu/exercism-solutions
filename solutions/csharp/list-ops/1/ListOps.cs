public static class ListOps
{
    public static int Length<T>(List<T> input)
    {
        var length = 0;
        foreach (var _ in input) length++;
        return length;
    }

    public static List<T> Reverse<T>(List<T> input)
    {
        var output = new List<T>();
        for (var index = input.Count - 1; index >= 0; index--) output.Add(input[index]);
        return output;
    }

    public static List<TOut> Map<TIn, TOut>(List<TIn> input, Func<TIn, TOut> map)
    {
        var output = new List<TOut>();
        foreach (var item in input) output.Add(map(item));
        return output;
    }

    public static List<T> Filter<T>(List<T> input, Func<T, bool> predicate)
    {
        var output = new List<T>();
        foreach (var item in input)
        {
            if (predicate(item)) output.Add(item);
        }

        return output;
    }

    public static TOut Foldl<TIn, TOut>(List<TIn> input, TOut start, Func<TOut, TIn, TOut> func)
    {
        var accumulator = start;
        foreach (var item in input) accumulator = func(accumulator, item);
        return accumulator;
    }

    public static TOut Foldr<TIn, TOut>(List<TIn> input, TOut start, Func<TIn, TOut, TOut> func)
    {
        var accumulator = start;
        for (var index = input.Count - 1; index >= 0; index--) accumulator = func(input[index], accumulator);
        return accumulator;
    }

    public static List<T> Concat<T>(List<List<T>> input)
    {
        var output = new List<T>();
        foreach (var list in input)
        {
            foreach (var item in list) output.Add(item);
        }

        return output;
    }

    public static List<T> Append<T>(List<T> left, List<T> right)
    {
        var output = new List<T>();
        foreach (var item in left) output.Add(item);
        foreach (var item in right) output.Add(item);
        return output;
    }
}
