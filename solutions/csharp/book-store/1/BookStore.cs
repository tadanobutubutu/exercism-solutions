public static class BookStore
{
    public static decimal Total(IEnumerable<int> books)
    {
        ArgumentNullException.ThrowIfNull(books);
        int[] counts = new int[5];
        foreach (int book in books)
        {
            if (book is < 1 or > 5)
            {
                throw new ArgumentException("Book identifiers must be between 1 and 5.", nameof(books));
            }
            counts[book - 1]++;
        }

        var memo = new Dictionary<string, decimal>();
        return Cheapest(counts);

        decimal Cheapest(int[] remaining)
        {
            if (remaining.All(count => count == 0)) return 0m;

            string key = string.Join(',', remaining);
            if (memo.TryGetValue(key, out decimal cached)) return cached;

            decimal best = decimal.MaxValue;
            for (int group = 1; group < 1 << 5; group++)
            {
                bool available = true;
                int groupSize = 0;
                for (int book = 0; book < 5; book++)
                {
                    if ((group & (1 << book)) == 0) continue;
                    groupSize++;
                    if (remaining[book] == 0)
                    {
                        available = false;
                        break;
                    }
                }
                if (!available) continue;

                int[] next = (int[])remaining.Clone();
                for (int book = 0; book < 5; book++)
                {
                    if ((group & (1 << book)) != 0) next[book]--;
                }

                decimal discount = groupSize switch
                {
                    2 => 0.05m,
                    3 => 0.10m,
                    4 => 0.20m,
                    5 => 0.25m,
                    _ => 0m
                };
                decimal price = groupSize * 8m * (1m - discount);
                best = Math.Min(best, price + Cheapest(next));
            }

            memo[key] = best;
            return best;
        }
    }
}
