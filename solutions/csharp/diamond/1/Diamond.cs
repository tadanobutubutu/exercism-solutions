public static class Diamond
{
    public static string Make(char target)
    {
        if (target is < 'A' or > 'Z')
        {
            throw new ArgumentOutOfRangeException(nameof(target));
        }

        int targetIndex = target - 'A';
        int width = targetIndex * 2 + 1;
        var rows = new List<string>(width);

        for (int row = 0; row < width; row++)
        {
            int letterIndex = row <= targetIndex ? row : width - row - 1;
            char letter = (char)('A' + letterIndex);
            int outerSpaces = targetIndex - letterIndex;
            string content = letterIndex == 0
                ? letter.ToString()
                : $"{letter}{new string(' ', letterIndex * 2 - 1)}{letter}";
            rows.Add(new string(' ', outerSpaces) + content + new string(' ', outerSpaces));
        }

        return string.Join("\n", rows);
    }
}
