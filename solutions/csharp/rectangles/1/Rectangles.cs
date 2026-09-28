public static class Rectangles
{
    public static int Count(string[] rows)
    {
        if (rows.Length == 0 || rows[0].Length == 0) return 0;

        var height = rows.Length;
        var width = rows[0].Length;
        var rectangles = 0;
        for (var top = 0; top < height; top++)
        {
            for (var left = 0; left < width; left++)
            {
                if (rows[top][left] != '+') continue;
                for (var right = left + 1; right < width; right++)
                {
                    if (rows[top][right] != '+' || !HorizontalSide(rows[top], left, right)) continue;
                    for (var bottom = top + 1; bottom < height; bottom++)
                    {
                        if (rows[bottom][left] == '+' && rows[bottom][right] == '+' &&
                            HorizontalSide(rows[bottom], left, right) && VerticalSide(rows, left, top, bottom) && VerticalSide(rows, right, top, bottom))
                        {
                            rectangles++;
                        }
                    }
                }
            }
        }

        return rectangles;
    }

    private static bool HorizontalSide(string row, int left, int right)
    {
        for (var column = left + 1; column < right; column++)
        {
            if (row[column] is not ('+' or '-')) return false;
        }

        return true;
    }

    private static bool VerticalSide(string[] rows, int column, int top, int bottom)
    {
        for (var row = top + 1; row < bottom; row++)
        {
            if (rows[row][column] is not ('+' or '|')) return false;
        }

        return true;
    }
}
