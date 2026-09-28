public static class FlowerField
{
    public static string[] Annotate(string[] input)
    {
        if (input.Length == 0) return [];

        var height = input.Length;
        var width = input[0].Length;
        var result = new string[height];
        for (var row = 0; row < height; row++)
        {
            var annotated = input[row].ToCharArray();
            for (var column = 0; column < width; column++)
            {
                if (input[row][column] == '*') continue;

                var flowers = 0;
                for (var rowOffset = -1; rowOffset <= 1; rowOffset++)
                {
                    for (var columnOffset = -1; columnOffset <= 1; columnOffset++)
                    {
                        if (rowOffset == 0 && columnOffset == 0) continue;
                        var neighborRow = row + rowOffset;
                        var neighborColumn = column + columnOffset;
                        if (neighborRow >= 0 && neighborRow < height && neighborColumn >= 0 && neighborColumn < width && input[neighborRow][neighborColumn] == '*')
                        {
                            flowers++;
                        }
                    }
                }

                if (flowers > 0) annotated[column] = (char)('0' + flowers);
            }

            result[row] = new string(annotated);
        }

        return result;
    }
}
