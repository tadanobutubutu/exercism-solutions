public static class SaddlePoints
{
    public static IEnumerable<(int, int)> Calculate(int[,] matrix)
    {
        ArgumentNullException.ThrowIfNull(matrix);

        int rowCount = matrix.GetLength(0);
        int columnCount = matrix.GetLength(1);
        if (rowCount == 0 || columnCount == 0)
        {
            return Array.Empty<(int, int)>();
        }

        var rowMaxima = new int[rowCount];
        var columnMinima = new int[columnCount];

        for (int row = 0; row < rowCount; row++)
        {
            int maximum = matrix[row, 0];
            for (int column = 1; column < columnCount; column++)
            {
                maximum = Math.Max(maximum, matrix[row, column]);
            }
            rowMaxima[row] = maximum;
        }

        for (int column = 0; column < columnCount; column++)
        {
            int minimum = matrix[0, column];
            for (int row = 1; row < rowCount; row++)
            {
                minimum = Math.Min(minimum, matrix[row, column]);
            }
            columnMinima[column] = minimum;
        }

        var points = new List<(int, int)>();
        for (int row = 0; row < rowCount; row++)
        {
            for (int column = 0; column < columnCount; column++)
            {
                int value = matrix[row, column];
                if (value == rowMaxima[row] && value == columnMinima[column])
                {
                    points.Add((row + 1, column + 1));
                }
            }
        }

        return points;
    }
}
