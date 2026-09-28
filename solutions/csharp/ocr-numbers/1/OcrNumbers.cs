using System.Text;

public static class OcrNumbers
{
    public static string Convert(string input)
    {
        var lines = input.Replace("\r", "").Split('\n').ToList();
        while (lines.Count > 0 && lines[^1].Length == 0) lines.RemoveAt(lines.Count - 1);
        if (lines.Count == 0 || lines.Count % 4 != 0) throw new ArgumentException("The input height must be a multiple of four.", nameof(input));

        var width = lines[0].Length;
        if (width == 0 || width % 3 != 0 || lines.Any(line => line.Length != width))
        {
            throw new ArgumentException("Each row must have a width divisible by three.", nameof(input));
        }

        var digits = new Dictionary<string, char>
        {
            [" _ | ||_|   "] = '0',
            ["     |  |   "] = '1',
            [" _  _||_    "] = '2',
            [" _  _| _|   "] = '3',
            ["   |_|  |   "] = '4',
            [" _ |_  _|   "] = '5',
            [" _ |_ |_|   "] = '6',
            [" _   |  |   "] = '7',
            [" _ |_||_|   "] = '8',
            [" _ |_| _|   "] = '9'
        };

        var outputRows = new List<string>();
        for (var group = 0; group < lines.Count; group += 4)
        {
            var output = new StringBuilder();
            for (var column = 0; column < width; column += 3)
            {
                var pattern = string.Concat(Enumerable.Range(0, 4).Select(row => lines[group + row].Substring(column, 3)));
                output.Append(digits.TryGetValue(pattern, out var digit) ? digit : '?');
            }

            outputRows.Add(output.ToString());
        }

        return string.Join(',', outputRows);
    }
}
