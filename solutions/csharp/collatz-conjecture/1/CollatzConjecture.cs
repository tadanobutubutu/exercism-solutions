public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(number));
        }

        long current = number;
        var steps = 0;

        while (current != 1)
        {
            current = current % 2 == 0 ? current / 2 : 3 * current + 1;
            steps++;
        }

        return steps;
    }
}
