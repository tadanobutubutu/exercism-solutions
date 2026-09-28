public static class EliudsEggs
{
    public static int EggCount(int encodedCount)
    {
        if (encodedCount < 0)
        {
            throw new ArgumentOutOfRangeException(nameof(encodedCount));
        }

        int eggs = 0;
        while (encodedCount > 0)
        {
            eggs += encodedCount & 1;
            encodedCount >>= 1;
        }
        return eggs;
    }
}
