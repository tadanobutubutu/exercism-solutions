public static class Etl
{
    public static Dictionary<string, int> Transform(Dictionary<int, string[]> old)
    {
        var transformed = new Dictionary<string, int>();
        foreach (var (score, letters) in old)
        {
            foreach (var letter in letters)
            {
                transformed[letter.ToLowerInvariant()] = score;
            }
        }

        return transformed;
    }
}
