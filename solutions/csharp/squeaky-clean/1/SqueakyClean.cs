using System.Text;

public static class Identifier
{
    public static string Clean(string identifier)
    {
        var cleaned = new StringBuilder();
        var capitalizeNext = false;
        foreach (var original in identifier)
        {
            if (original == '-')
            {
                capitalizeNext = true;
                continue;
            }
            if (char.IsControl(original))
            {
                cleaned.Append("CTRL");
                continue;
            }

            var character = original == ' ' ? '_' : original;
            if (capitalizeNext)
            {
                character = char.ToUpperInvariant(character);
                capitalizeNext = false;
            }

            if (character is >= '\u03b1' and <= '\u03c9') continue;
            if (character == '_' || char.IsLetter(character)) cleaned.Append(character);
        }
        return cleaned.ToString();
    }
}
