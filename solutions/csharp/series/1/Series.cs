public static class Series
{
    public static string[] Slices(string numbers, int sliceLength)
    {
        if (sliceLength <= 0 || sliceLength > numbers.Length)
        {
            throw new ArgumentException("The slice length must be positive and no larger than the input.");
        }

        return Enumerable.Range(0, numbers.Length - sliceLength + 1)
            .Select(start => numbers.Substring(start, sliceLength))
            .ToArray();
    }
}
