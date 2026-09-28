public static class SquareRoot
{
    public static int Root(int number)
    {
        if (number < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(number));
        }
        if (number < 2) return number;

        long low = 1;
        long high = Math.Min(number, 46340);
        while (low <= high)
        {
            long middle = low + (high - low) / 2;
            long square = middle * middle;
            if (square == number) return (int)middle;
            if (square < number) low = middle + 1;
            else high = middle - 1;
        }

        return (int)high;
    }
}
