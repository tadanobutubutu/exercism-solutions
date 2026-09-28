public class Matrix
{
    private readonly int[][] rows;

    public Matrix(string input)
    {
        rows = input.Split('\n', StringSplitOptions.RemoveEmptyEntries)
            .Select(line => line.TrimEnd('\r').Split((char[]?)null, StringSplitOptions.RemoveEmptyEntries).Select(int.Parse).ToArray())
            .ToArray();
    }

    public int[] Row(int row)
    {
        return rows[row - 1].ToArray();
    }

    public int[] Column(int col)
    {
        return rows.Select(row => row[col - 1]).ToArray();
    }
}
