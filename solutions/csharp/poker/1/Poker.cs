public static class Poker
{
    public static IEnumerable<string> BestHands(IEnumerable<string> hands)
    {
        ArgumentNullException.ThrowIfNull(hands);
        var rankedHands = hands.Select(hand => (Hand: hand, Score: Score(hand))).ToArray();
        if (rankedHands.Length == 0) return [];

        int[] bestScore = rankedHands[0].Score;
        foreach (var hand in rankedHands.Skip(1))
            if (Compare(hand.Score, bestScore) > 0) bestScore = hand.Score;

        return rankedHands
            .Where(hand => Compare(hand.Score, bestScore) == 0)
            .Select(hand => hand.Hand)
            .ToArray();
    }

    private static int[] Score(string hand)
    {
        string[] cards = hand.Split(' ', StringSplitOptions.RemoveEmptyEntries);
        if (cards.Length != 5) throw new ArgumentException("Each hand must contain five cards.", nameof(hand));

        int[] ranks = cards.Select(card => Rank(card[..^1])).ToArray();
        int[] descendingRanks = ranks.OrderDescending().ToArray();
        bool flush = cards.Select(card => card[^1]).Distinct().Count() == 1;
        int[] uniqueRanks = ranks.Distinct().Order().ToArray();
        bool straight = false;
        int straightHigh = 0;
        if (uniqueRanks.Length == 5)
        {
            if (uniqueRanks[^1] - uniqueRanks[0] == 4)
            {
                straight = true;
                straightHigh = uniqueRanks[^1];
            }
            else if (uniqueRanks.SequenceEqual([2, 3, 4, 5, 14]))
            {
                straight = true;
                straightHigh = 5;
            }
        }

        var groups = ranks
            .GroupBy(rank => rank)
            .Select(group => (Rank: group.Key, Count: group.Count()))
            .OrderByDescending(group => group.Count)
            .ThenByDescending(group => group.Rank)
            .ToArray();

        if (straight && flush) return [8, straightHigh];
        if (groups[0].Count == 4) return [7, groups[0].Rank, groups[1].Rank];
        if (groups[0].Count == 3 && groups[1].Count == 2) return [6, groups[0].Rank, groups[1].Rank];
        if (flush) return [5, .. descendingRanks];
        if (straight) return [4, straightHigh];
        if (groups[0].Count == 3)
            return [3, groups[0].Rank, .. groups.Skip(1).Select(group => group.Rank).OrderDescending()];
        if (groups[0].Count == 2 && groups[1].Count == 2)
        {
            int highPair = Math.Max(groups[0].Rank, groups[1].Rank);
            int lowPair = Math.Min(groups[0].Rank, groups[1].Rank);
            return [2, highPair, lowPair, groups[2].Rank];
        }
        if (groups[0].Count == 2)
            return [1, groups[0].Rank, .. groups.Skip(1).Select(group => group.Rank).OrderDescending()];
        return [0, .. descendingRanks];
    }

    private static int Rank(string rank) => rank switch
    {
        "J" => 11,
        "Q" => 12,
        "K" => 13,
        "A" => 14,
        _ when int.TryParse(rank, out int value) && value is >= 2 and <= 10 => value,
        _ => throw new ArgumentException($"Invalid card rank: {rank}")
    };

    private static int Compare(int[] left, int[] right)
    {
        for (int index = 0; index < Math.Min(left.Length, right.Length); index++)
        {
            int comparison = left[index].CompareTo(right[index]);
            if (comparison != 0) return comparison;
        }
        return left.Length.CompareTo(right.Length);
    }
}
