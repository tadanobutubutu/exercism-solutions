public static class Pangram
{
    public static bool IsPangram(string input)
    {
        var letters = new bool[26];
        var distinctCount = 0;

        foreach (var character in input)
        {
            var lower = char.ToLowerInvariant(character);
            if (lower is < 'a' or > 'z')
            {
                continue;
            }

            var index = lower - 'a';
            if (!letters[index])
            {
                letters[index] = true;
                distinctCount++;
            }
        }

        return distinctCount == 26;
    }
}
