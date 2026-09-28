public static class ScrabbleScore
{
    public static int Score(string input)
    {
        var score = 0;
        foreach (var character in input)
        {
            score += char.ToUpperInvariant(character) switch
            {
                'D' or 'G' => 2,
                'B' or 'C' or 'M' or 'P' => 3,
                'F' or 'H' or 'V' or 'W' or 'Y' => 4,
                'K' => 5,
                'J' or 'X' => 8,
                'Q' or 'Z' => 10,
                >= 'A' and <= 'Z' => 1,
                _ => 0
            };
        }

        return score;
    }
}
