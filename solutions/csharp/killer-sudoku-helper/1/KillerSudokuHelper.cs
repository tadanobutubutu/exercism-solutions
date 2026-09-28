public static class KillerSudokuHelper
{
    public static IEnumerable<int[]> Combinations(int sum, int size, int[] exclude)
    {
        ArgumentNullException.ThrowIfNull(exclude);
        if (size < 1 || size > 9) return [];

        var excluded = exclude.ToHashSet();
        var current = new List<int>(size);
        var combinations = new List<int[]>();

        void Search(int nextDigit, int remainingSum)
        {
            if (current.Count == size)
            {
                if (remainingSum == 0) combinations.Add(current.ToArray());
                return;
            }

            for (int digit = nextDigit; digit <= 9; digit++)
            {
                if (excluded.Contains(digit)) continue;
                if (digit > remainingSum) break;

                current.Add(digit);
                Search(digit + 1, remainingSum - digit);
                current.RemoveAt(current.Count - 1);
            }
        }

        Search(1, sum);
        return combinations;
    }
}
