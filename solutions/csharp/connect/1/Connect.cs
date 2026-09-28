public enum ConnectWinner
{
    White,
    Black,
    None
}

public class Connect
{
    private readonly char[][] board;

    public Connect(string[] input)
    {
        board = input.Select(row => row.Where(character => character is 'X' or 'O' or '.').ToArray()).ToArray();
    }
    
    public ConnectWinner Result()
    {
        if (HasPath('O', startsAtTop: true)) return ConnectWinner.White;
        if (HasPath('X', startsAtTop: false)) return ConnectWinner.Black;
        return ConnectWinner.None;
    }

    private bool HasPath(char stone, bool startsAtTop)
    {
        if (board.Length == 0) return false;
        var height = board.Length;
        var width = board[0].Length;
        var queue = new Queue<(int Row, int Column)>();
        var visited = new bool[height, width];

        if (startsAtTop)
        {
            for (var column = 0; column < width; column++)
            {
                if (board[0][column] == stone)
                {
                    queue.Enqueue((0, column));
                    visited[0, column] = true;
                }
            }
        }
        else
        {
            for (var row = 0; row < height; row++)
            {
                if (board[row][0] == stone)
                {
                    queue.Enqueue((row, 0));
                    visited[row, 0] = true;
                }
            }
        }

        var offsets = new (int Row, int Column)[] { (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0) };
        while (queue.Count > 0)
        {
            var (row, column) = queue.Dequeue();
            if (startsAtTop ? row == height - 1 : column == width - 1) return true;

            foreach (var (rowOffset, columnOffset) in offsets)
            {
                var nextRow = row + rowOffset;
                var nextColumn = column + columnOffset;
                if (nextRow >= 0 && nextRow < height && nextColumn >= 0 && nextColumn < width &&
                    !visited[nextRow, nextColumn] && board[nextRow][nextColumn] == stone)
                {
                    visited[nextRow, nextColumn] = true;
                    queue.Enqueue((nextRow, nextColumn));
                }
            }
        }

        return false;
    }
}
