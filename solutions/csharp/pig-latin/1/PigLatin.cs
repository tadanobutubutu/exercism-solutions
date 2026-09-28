public static class PigLatin
{
    public static string Translate(string word)
    {
        ArgumentNullException.ThrowIfNull(word);
        return string.Join(" ", word.Split(' ').Select(TranslateToken));
    }

    private static string TranslateToken(string word)
    {
        if (word.Length == 0)
        {
            return word;
        }

        if (StartsWithVowelSound(word))
        {
            return word + "ay";
        }

        int clusterLength = 0;
        while (clusterLength < word.Length)
        {
            char current = word[clusterLength];
            if (IsVowel(current) && !(current == 'u' && clusterLength > 0 && word[clusterLength - 1] == 'q'))
            {
                break;
            }
            if (current == 'y' && clusterLength > 0)
            {
                break;
            }
            clusterLength++;
        }

        return word[clusterLength..] + word[..clusterLength] + "ay";
    }

    private static bool StartsWithVowelSound(string word) =>
        IsVowel(word[0]) || word.StartsWith("xr", StringComparison.Ordinal) || word.StartsWith("yt", StringComparison.Ordinal);

    private static bool IsVowel(char character) => character is 'a' or 'e' or 'i' or 'o' or 'u';
}
