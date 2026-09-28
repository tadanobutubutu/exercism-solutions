public static class CryptoSquare
{
    public static string Ciphertext(string plaintext)
    {
        var normalized = new string(plaintext.Where(char.IsLetterOrDigit).Select(char.ToLowerInvariant).ToArray());
        if (normalized.Length == 0) return string.Empty;

        var columns = (int)Math.Ceiling(Math.Sqrt(normalized.Length));
        var rows = (int)Math.Ceiling((double)normalized.Length / columns);
        var chunks = new string[columns];
        for (var column = 0; column < columns; column++)
        {
            var chunk = new char[rows];
            for (var row = 0; row < rows; row++)
            {
                var index = row * columns + column;
                chunk[row] = index < normalized.Length ? normalized[index] : ' ';
            }

            chunks[column] = new string(chunk);
        }

        return string.Join(' ', chunks);
    }
}
