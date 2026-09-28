public class Anagram
{
    private readonly string _baseWord;
    private readonly string _normalizedBaseWord;

    public Anagram(string baseWord)
    {
        _baseWord = baseWord;
        _normalizedBaseWord = Normalize(baseWord);
    }

    public string[] FindAnagrams(string[] potentialMatches)
    {
        return potentialMatches
            .Where(candidate => !string.Equals(candidate, _baseWord, StringComparison.OrdinalIgnoreCase))
            .Where(candidate => Normalize(candidate) == _normalizedBaseWord)
            .ToArray();
    }

    private static string Normalize(string word) =>
        string.Concat(word.ToUpperInvariant().OrderBy(character => character));
}
