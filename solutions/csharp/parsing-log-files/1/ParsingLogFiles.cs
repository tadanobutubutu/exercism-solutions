using System.Text.RegularExpressions;

public class LogParser
{
    private static readonly Regex ValidLine = new(@"^\[(TRC|DBG|INF|WRN|ERR|FTL)\]", RegexOptions.Compiled);
    private static readonly Regex QuotedPassword = new("\"[^\"]*password[^\"]*\"", RegexOptions.IgnoreCase | RegexOptions.Compiled);
    private static readonly Regex EndOfLineArtifact = new(@"end-of-line\d+", RegexOptions.Compiled);
    private static readonly Regex WeakPassword = new(@"password\S+", RegexOptions.IgnoreCase | RegexOptions.Compiled);

    public bool IsValidLine(string text)
    {
        return ValidLine.IsMatch(text);
    }

    public string[] SplitLogLine(string text)
    {
        return Regex.Split(text, @"<[-^*=]+>");
    }

    public int CountQuotedPasswords(string lines)
    {
        return Regex.Split(lines, @"\r\n|\n|\r")
            .Count(line => QuotedPassword.IsMatch(line));
    }

    public string RemoveEndOfLineText(string line)
    {
        return EndOfLineArtifact.Replace(line, string.Empty);
    }

    public string[] ListLinesWithPasswords(string[] lines)
    {
        return lines.Select(line =>
        {
            Match match = WeakPassword.Match(line);
            return match.Success ? $"{match.Value}: {line}" : $"--------: {line}";
        }).ToArray();
    }
}
