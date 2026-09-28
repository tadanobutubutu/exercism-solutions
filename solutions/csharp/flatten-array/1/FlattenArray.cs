using System.Collections;

public static class FlattenArray
{
    public static IEnumerable Flatten(IEnumerable input)
    {
        var flattened = new List<object?>();
        FlattenInto(input, flattened);
        return flattened;
    }

    private static void FlattenInto(IEnumerable input, List<object?> output)
    {
        foreach (var item in input)
        {
            if (item is null) continue;
            if (item is IEnumerable nested && item is not string)
            {
                FlattenInto(nested, output);
            }
            else
            {
                output.Add(item);
            }
        }
    }
}
