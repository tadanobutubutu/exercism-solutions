public static class NthPrime
{
    public static int Prime(int nth)
    {
        if (nth < 1)
        {
            throw new ArgumentOutOfRangeException(nameof(nth));
        }

        if (nth == 1) return 2;
        int count = 1;
        for (int candidate = 3; ; candidate += 2)
        {
            if (!IsPrime(candidate)) continue;
            if (++count == nth) return candidate;
        }
    }

    private static bool IsPrime(int number)
    {
        for (int divisor = 3; (long)divisor * divisor <= number; divisor += 2)
        {
            if (number % divisor == 0) return false;
        }
        return true;
    }
}
