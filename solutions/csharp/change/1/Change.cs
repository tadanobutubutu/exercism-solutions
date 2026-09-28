public static class Change
{
    public static int[] FindFewestCoins(int[] coins, int target)
    {
        if (target < 0 || coins.Any(coin => coin <= 0)) throw new ArgumentException("Target and coin values must be non-negative.");
        if (target == 0) return [];

        var best = Enumerable.Repeat(int.MaxValue, target + 1).ToArray();
        var previousCoin = new int[target + 1];
        best[0] = 0;

        for (var amount = 1; amount <= target; amount++)
        {
            foreach (var coin in coins)
            {
                if (coin <= amount && best[amount - coin] != int.MaxValue && best[amount - coin] + 1 < best[amount])
                {
                    best[amount] = best[amount - coin] + 1;
                    previousCoin[amount] = coin;
                }
            }
        }

        if (best[target] == int.MaxValue) throw new ArgumentException("The target cannot be made with the given coins.");
        var change = new List<int>();
        for (var amount = target; amount > 0; amount -= previousCoin[amount]) change.Add(previousCoin[amount]);
        change.Sort();
        return change.ToArray();
    }
}
