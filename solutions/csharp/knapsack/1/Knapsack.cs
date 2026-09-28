public static class Knapsack
{
    public static int MaximumValue(int maximumWeight, (int weight, int value)[] items)
    {
        ArgumentNullException.ThrowIfNull(items);
        if (maximumWeight < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(maximumWeight));
        }

        var bestAtWeight = new int[maximumWeight + 1];
        foreach (var (weight, value) in items)
        {
            if (weight <= 0 || value < 0)
            {
                throw new ArgumentException("Items must have positive weight and non-negative value.", nameof(items));
            }
            for (int capacity = maximumWeight; capacity >= weight; capacity--)
            {
                bestAtWeight[capacity] = Math.Max(bestAtWeight[capacity], bestAtWeight[capacity - weight] + value);
            }
        }

        return bestAtWeight[maximumWeight];
    }
}
