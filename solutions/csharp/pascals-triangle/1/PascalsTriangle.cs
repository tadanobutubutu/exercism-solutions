public static class PascalsTriangle
{
    public static IEnumerable<IEnumerable<int>> Calculate(int rows)
    {
        if (rows < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(rows));
        }

        var result = new List<IEnumerable<int>>();
        var previous = Array.Empty<int>();

        for (var rowIndex = 0; rowIndex < rows; rowIndex++)
        {
            var row = new int[rowIndex + 1];
            row[0] = 1;
            row[^1] = 1;
            for (var column = 1; column < rowIndex; column++)
            {
                row[column] = previous[column - 1] + previous[column];
            }

            result.Add(row);
            previous = row;
        }

        return result;
    }

}
