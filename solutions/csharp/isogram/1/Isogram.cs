public static class Isogram
{
    public static bool IsIsogram(string word)
    {
        var seen = new HashSet<char>();
        foreach (var character in word)
        {
            if (!char.IsLetter(character))
            {
                continue;
            }

            if (!seen.Add(char.ToLowerInvariant(character)))
            {
                return false;
            }
        }

        return true;
    }
}
