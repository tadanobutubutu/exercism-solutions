public static class Transpose
{
    public static string String(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        if (input.Length == 0) return string.Empty;

        string[] rows = input.Replace("\r\n", "\n", StringComparison.Ordinal).Split('\n');
        int maximumWidth = rows.Max(row => row.Length);
        var transposedRows = new List<string>(maximumWidth);

        for (int column = 0; column < maximumWidth; column++)
        {
            int lastRowWithCharacter = Array.FindLastIndex(rows, row => row.Length > column);
            var characters = new char[lastRowWithCharacter + 1];
            for (int row = 0; row <= lastRowWithCharacter; row++)
            {
                characters[row] = column < rows[row].Length ? rows[row][column] : ' ';
            }
            transposedRows.Add(new string(characters));
        }

        return string.Join("\n", transposedRows);
    }
}
