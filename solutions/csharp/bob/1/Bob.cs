public static class Bob
{
    public static string Response(string statement)
    {
        if (string.IsNullOrWhiteSpace(statement))
        {
            return "Fine. Be that way!";
        }

        var letters = statement.Where(char.IsLetter).ToArray();
        var yelling = letters.Length > 0 && letters.All(char.IsUpper);
        var question = statement.TrimEnd().EndsWith('?');

        if (yelling && question)
        {
            return "Calm down, I know what I'm doing!";
        }

        if (yelling)
        {
            return "Whoa, chill out!";
        }

        return question ? "Sure." : "Whatever.";
    }
}
