static class LogLine
{
    public static string Message(string logLine)
    {
        var separator = logLine.IndexOf(": ", StringComparison.Ordinal);
        return separator < 0 ? logLine.Trim() : logLine[(separator + 2)..].Trim();
    }

    public static string LogLevel(string logLine)
    {
        var closingBracket = logLine.IndexOf(']');
        return closingBracket <= 1 ? string.Empty : logLine[1..closingBracket].ToLowerInvariant();
    }

    public static string Reformat(string logLine)
    {
        return $"{Message(logLine)} ({LogLevel(logLine)})";
    }
}
