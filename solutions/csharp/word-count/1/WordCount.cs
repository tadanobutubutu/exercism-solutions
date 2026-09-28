using System.Text.RegularExpressions;

public static class WordCount
{
    public static IDictionary<string, int> CountWords(string phrase)
    {
        ArgumentNullException.ThrowIfNull(phrase);

        var counts = new Dictionary<string, int>();
        foreach (Match match in Regex.Matches(phrase.ToLowerInvariant(), @"\w+'\w+|\w+", RegexOptions.CultureInvariant))
        {
            counts.TryGetValue(match.Value, out int count);
            counts[match.Value] = count + 1;
        }

        return counts;
    }
}
