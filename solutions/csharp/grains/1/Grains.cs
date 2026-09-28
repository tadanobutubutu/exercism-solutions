public static class Grains
{
    public static ulong Square(int n)
    {
        if (n is < 1 or > 64)
        {
            throw new ArgumentOutOfRangeException(nameof(n));
        }

        return 1UL << (n - 1);
    }

    public static ulong Total()
    {
        return ulong.MaxValue;
    }
}
