using System;

public static class GameOfLife
{
    public static int[,] Tick(int[,] matrix)
    {
        ArgumentNullException.ThrowIfNull(matrix);

        int rows = matrix.GetLength(0);
        int columns = matrix.GetLength(1);
        var next = new int[rows, columns];

        for (int row = 0; row < rows; row++)
        {
            for (int column = 0; column < columns; column++)
            {
                int neighbors = 0;
                for (int rowOffset = -1; rowOffset <= 1; rowOffset++)
                {
                    for (int columnOffset = -1; columnOffset <= 1; columnOffset++)
                    {
                        if (rowOffset == 0 && columnOffset == 0) continue;
                        int neighborRow = row + rowOffset;
                        int neighborColumn = column + columnOffset;
                        if (neighborRow >= 0 && neighborRow < rows
                            && neighborColumn >= 0 && neighborColumn < columns)
                        {
                            neighbors += matrix[neighborRow, neighborColumn];
                        }
                    }
                }

                next[row, column] = matrix[row, column] == 1
                    ? (neighbors is 2 or 3 ? 1 : 0)
                    : (neighbors == 3 ? 1 : 0);
            }
        }

        return next;
    }
}
