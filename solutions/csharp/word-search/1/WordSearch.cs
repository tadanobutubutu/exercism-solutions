public class WordSearch
{
    private readonly string[] grid;
    private readonly int width;

    public WordSearch(string grid)
    {
        ArgumentNullException.ThrowIfNull(grid);
        this.grid = grid.Replace("\r\n", "\n", StringComparison.Ordinal).Split('\n');
        width = this.grid.Length == 0 ? 0 : this.grid[0].Length;
        if (this.grid.Any(row => row.Length != width))
        {
            throw new ArgumentException("All rows in the grid must have the same width.", nameof(grid));
        }
    }

    public Dictionary<string, ((int, int), (int, int))?> Search(string[] wordsToSearchFor)
    {
        ArgumentNullException.ThrowIfNull(wordsToSearchFor);
        var results = new Dictionary<string, ((int, int), (int, int))?>();
        (int Dx, int Dy)[] directions =
        [
            (1, 0), (-1, 0), (0, 1), (0, -1),
            (1, 1), (-1, -1), (1, -1), (-1, 1)
        ];

        foreach (string word in wordsToSearchFor)
        {
            results[word] = Find(word, directions);
        }

        return results;
    }

    private ((int, int), (int, int))? Find(string word, (int Dx, int Dy)[] directions)
    {
        if (string.IsNullOrEmpty(word))
        {
            return null;
        }

        for (int y = 0; y < grid.Length; y++)
        {
            for (int x = 0; x < width; x++)
            {
                foreach (var (dx, dy) in directions)
                {
                    int endX = x + (word.Length - 1) * dx;
                    int endY = y + (word.Length - 1) * dy;
                    if (endX < 0 || endX >= width || endY < 0 || endY >= grid.Length)
                    {
                        continue;
                    }

                    bool matches = true;
                    for (int index = 0; index < word.Length; index++)
                    {
                        if (grid[y + index * dy][x + index * dx] != word[index])
                        {
                            matches = false;
                            break;
                        }
                    }

                    if (matches)
                    {
                        return ((x + 1, y + 1), (endX + 1, endY + 1));
                    }
                }
            }
        }

        return null;
    }
}
