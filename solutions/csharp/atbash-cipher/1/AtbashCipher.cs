using System.Text;

public static class AtbashCipher
{
    public static string Encode(string plainValue)
    {
        var encoded = Transform(plainValue);
        var groups = Enumerable.Range(0, (encoded.Length + 4) / 5)
            .Select(index => encoded.Substring(index * 5, Math.Min(5, encoded.Length - index * 5)));
        return string.Join(' ', groups);
    }

    public static string Decode(string encodedValue)
    {
        return Transform(encodedValue);
    }

    private static string Transform(string input)
    {
        var output = new StringBuilder();
        foreach (var character in input)
        {
            if (char.IsAsciiLetterLower(character)) output.Append((char)('z' - character + 'a'));
            else if (char.IsAsciiLetterUpper(character)) output.Append((char)('z' - char.ToLowerInvariant(character) + 'a'));
            else if (char.IsAsciiDigit(character)) output.Append(character);
        }

        return output.ToString();
    }
}
