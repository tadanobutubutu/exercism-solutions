public static class Acronym
{
    public static string Abbreviate(string phrase)
    {
        var initials = new System.Text.StringBuilder();
        var startOfWord = true;

        foreach (var character in phrase)
        {
            if (char.IsWhiteSpace(character) || character is '-' or '_')
            {
                startOfWord = true;
                continue;
            }

            if (!char.IsLetterOrDigit(character))
            {
                continue;
            }

            if (startOfWord)
            {
                initials.Append(char.ToUpperInvariant(character));
                startOfWord = false;
            }
        }

        return initials.ToString();
    }
}
