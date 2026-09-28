public static class SumOfMultiples
{
    public static int Sum(IEnumerable<int> multiples, int max)
    {
        var values = new HashSet<int>();
        foreach (var multiple in multiples)
        {
            var step = Math.Abs((long)multiple);
            if (step == 0)
            {
                continue;
            }

            for (long value = step; value < max; value += step)
            {
                values.Add((int)value);
            }
        }

        return values.Sum();
    }
}
