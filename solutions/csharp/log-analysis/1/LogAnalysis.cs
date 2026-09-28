public static class LogAnalysis 
{
    public static string SubstringAfter(this string input, string delimiter)
    {
        int delimiterIndex = input.IndexOf(delimiter, StringComparison.Ordinal);
        if (delimiterIndex < 0)
        {
            throw new ArgumentException("Delimiter was not found in the input.", nameof(delimiter));
        }

        return input[(delimiterIndex + delimiter.Length)..];
    }

    public static string SubstringBetween(this string input, string start, string end)
    {
        int startIndex = input.IndexOf(start, StringComparison.Ordinal);
        if (startIndex < 0)
        {
            throw new ArgumentException("Start delimiter was not found in the input.", nameof(start));
        }

        int contentStart = startIndex + start.Length;
        int endIndex = input.IndexOf(end, contentStart, StringComparison.Ordinal);
        if (endIndex < 0)
        {
            throw new ArgumentException("End delimiter was not found in the input.", nameof(end));
        }

        return input[contentStart..endIndex];
    }
    
    public static string Message(this string log) => log.SubstringAfter(": ");

    public static string LogLevel(this string log) => log.SubstringBetween("[", "]");
}
