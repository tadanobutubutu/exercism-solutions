public enum YachtCategory
{
    Ones = 1,
    Twos = 2,
    Threes = 3,
    Fours = 4,
    Fives = 5,
    Sixes = 6,
    FullHouse = 7,
    FourOfAKind = 8,
    LittleStraight = 9,
    BigStraight = 10,
    Choice = 11,
    Yacht = 12,
}

public static class YachtGame
{
    public static int Score(int[] dice, YachtCategory category)
    {
        ArgumentNullException.ThrowIfNull(dice);
        if (dice.Length != 5 || dice.Any(die => die is < 1 or > 6))
        {
            throw new ArgumentException("A yacht roll must contain five six-sided dice.", nameof(dice));
        }

        var counts = dice.GroupBy(die => die).ToDictionary(group => group.Key, group => group.Count());
        return category switch
        {
            YachtCategory.Ones => dice.Where(die => die == 1).Sum(),
            YachtCategory.Twos => dice.Where(die => die == 2).Sum(),
            YachtCategory.Threes => dice.Where(die => die == 3).Sum(),
            YachtCategory.Fours => dice.Where(die => die == 4).Sum(),
            YachtCategory.Fives => dice.Where(die => die == 5).Sum(),
            YachtCategory.Sixes => dice.Where(die => die == 6).Sum(),
            YachtCategory.FullHouse => counts.Count == 2 && counts.Values.Order().SequenceEqual([2, 3]) ? dice.Sum() : 0,
            YachtCategory.FourOfAKind => counts.FirstOrDefault(pair => pair.Value >= 4) is var pair && pair.Value >= 4 ? pair.Key * 4 : 0,
            YachtCategory.LittleStraight => dice.Order().SequenceEqual([1, 2, 3, 4, 5]) ? 30 : 0,
            YachtCategory.BigStraight => dice.Order().SequenceEqual([2, 3, 4, 5, 6]) ? 30 : 0,
            YachtCategory.Choice => dice.Sum(),
            YachtCategory.Yacht => counts.Count == 1 ? 50 : 0,
            _ => 0
        };
    }
}
