using System.Text.RegularExpressions;

public static class Markdown
{
    public static string Parse(string markdown)
    {
        ArgumentNullException.ThrowIfNull(markdown);
        var html = new List<string>();
        bool insideList = false;

        foreach (string line in markdown.Split('\n'))
        {
            int headerLevel = CountLeadingHashes(line);
            if (headerLevel is >= 1 and <= 6 && line.Length > headerLevel && line[headerLevel] == ' ')
            {
                CloseListIfNeeded(html, ref insideList);
                string headerText = line[(headerLevel + 1)..];
                html.Add($"<h{headerLevel}>{headerText}</h{headerLevel}>");
            }
            else if (line.StartsWith("* ", StringComparison.Ordinal))
            {
                if (!insideList)
                {
                    html.Add("<ul>");
                    insideList = true;
                }
                html.Add($"<li>{FormatInline(line[2..])}</li>");
            }
            else
            {
                CloseListIfNeeded(html, ref insideList);
                html.Add($"<p>{FormatInline(line)}</p>");
            }
        }

        CloseListIfNeeded(html, ref insideList);
        return string.Concat(html);
    }

    private static int CountLeadingHashes(string text) => text.TakeWhile(character => character == '#').Count();

    private static string FormatInline(string text)
    {
        string bold = Regex.Replace(text, @"__(.+?)__", "<strong>$1</strong>");
        return Regex.Replace(bold, @"(?<!_)_(.+?)_(?!_)", "<em>$1</em>");
    }

    private static void CloseListIfNeeded(List<string> html, ref bool insideList)
    {
        if (insideList)
        {
            html.Add("</ul>");
            insideList = false;
        }
    }
}
