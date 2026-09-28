public enum State
{
    Win,
    Draw,
    Ongoing,
    Invalid
}

public class TicTacToe
{
    private readonly string[] rows;

    public TicTacToe(string[] rows)
    {
        this.rows = rows ?? [];
    }
    
    public State State
    {
        get
        {
            if (rows.Length != 3 || rows.Any(row => row is null || row.Length != 3 || row.Any(mark => mark is not ('X' or 'O' or ' '))))
            {
                return State.Invalid;
            }

            int xCount = rows.Sum(row => row.Count(mark => mark == 'X'));
            int oCount = rows.Sum(row => row.Count(mark => mark == 'O'));
            if (xCount < oCount || xCount > oCount + 1)
            {
                return State.Invalid;
            }

            bool xWins = HasWinner('X');
            bool oWins = HasWinner('O');
            if (xWins && oWins)
            {
                return State.Invalid;
            }
            if (xWins && xCount != oCount + 1 || oWins && xCount != oCount)
            {
                return State.Invalid;
            }

            if (xWins || oWins)
            {
                char winner = xWins ? 'X' : 'O';
                if (!HasPossibleLastWinningMove(winner))
                {
                    return State.Invalid;
                }
                return State.Win;
            }

            return xCount + oCount == 9 ? State.Draw : State.Ongoing;
        }
    }

    private bool HasWinner(char mark)
        => HasWinnerIn(rows, mark);

    private static bool HasWinnerIn(string[] board, char mark)
    {
        for (int index = 0; index < 3; index++)
        {
            if (board[index].All(cell => cell == mark)) return true;
            if (board.All(row => row[index] == mark)) return true;
        }

        return board[0][0] == mark && board[1][1] == mark && board[2][2] == mark
            || board[0][2] == mark && board[1][1] == mark && board[2][0] == mark;
    }

    private bool HasPossibleLastWinningMove(char winner)
    {
        char[][] board = rows.Select(row => row.ToCharArray()).ToArray();
        for (int row = 0; row < 3; row++)
        {
            for (int column = 0; column < 3; column++)
            {
                if (board[row][column] != winner) continue;
                board[row][column] = ' ';
                string[] previous = board.Select(current => new string(current)).ToArray();
                bool gameHadAlreadyEnded = HasWinnerIn(previous, 'X') || HasWinnerIn(previous, 'O');
                board[row][column] = winner;
                if (!gameHadAlreadyEnded) return true;
            }
        }

        return false;
    }
}
