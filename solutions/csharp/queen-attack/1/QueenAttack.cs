public class Queen
{
    public Queen(int row, int column)
    {
        Row = row;
        Column = column;
    }

    public int Row { get; }
    public int Column { get; }
}

public static class QueenAttack
{
    public static bool CanAttack(Queen white, Queen black)
    {
        ArgumentNullException.ThrowIfNull(white);
        ArgumentNullException.ThrowIfNull(black);
        long rowDistance = Math.Abs((long)white.Row - black.Row);
        long columnDistance = Math.Abs((long)white.Column - black.Column);
        return white.Row == black.Row || white.Column == black.Column || rowDistance == columnDistance;
    }

    public static Queen Create(int row, int column)
    {
        if (row is < 0 or > 7)
        {
            throw new ArgumentOutOfRangeException(nameof(row));
        }
        if (column is < 0 or > 7)
        {
            throw new ArgumentOutOfRangeException(nameof(column));
        }

        return new Queen(row, column);
    }
}
