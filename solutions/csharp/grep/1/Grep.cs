using System.IO;

public static class Grep
{
    public static string Match(string pattern, string flags, string[] files)
    {
        ArgumentNullException.ThrowIfNull(pattern);
        ArgumentNullException.ThrowIfNull(flags);
        ArgumentNullException.ThrowIfNull(files);

        HashSet<string> options = flags.Split(' ', StringSplitOptions.RemoveEmptyEntries).ToHashSet(StringComparer.Ordinal);
        bool includeLineNumber = options.Contains("-n");
        bool onlyFileNames = options.Contains("-l");
        bool ignoreCase = options.Contains("-i");
        bool invert = options.Contains("-v");
        bool matchWholeLine = options.Contains("-x");
        StringComparison comparison = ignoreCase ? StringComparison.OrdinalIgnoreCase : StringComparison.Ordinal;
        var output = new List<string>();

        foreach (string file in files)
        {
            string[] lines = File.ReadAllLines(file);
            var matches = new List<(int LineNumber, string Text)>();

            for (int index = 0; index < lines.Length; index++)
            {
                string line = lines[index];
                bool found = matchWholeLine
                    ? string.Equals(line, pattern, comparison)
                    : line.Contains(pattern, comparison);
                if (invert ? !found : found)
                {
                    matches.Add((index + 1, line));
                }
            }

            if (onlyFileNames)
            {
                if (matches.Count > 0)
                {
                    output.Add(file);
                }
                continue;
            }

            foreach (var (lineNumber, text) in matches)
            {
                string result = includeLineNumber ? $"{lineNumber}:{text}" : text;
                if (files.Length > 1)
                {
                    result = $"{file}:{result}";
                }
                output.Add(result);
            }
        }

        return string.Join("\n", output);
    }
}
