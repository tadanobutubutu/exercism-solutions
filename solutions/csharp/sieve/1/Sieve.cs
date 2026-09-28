public static class Sieve
{
    public static int[] Primes(int limit)
    {
        if (limit < 2)
        {
            return Array.Empty<int>();
        }

        var composite = new bool[limit + 1];
        for (var prime = 2; prime <= limit / prime; prime++)
        {
            if (composite[prime])
            {
                continue;
            }

            for (var multiple = prime * prime; multiple <= limit; multiple += prime)
            {
                composite[multiple] = true;
            }
        }

        var primes = new List<int>();
        for (var number = 2; number <= limit; number++)
        {
            if (!composite[number])
            {
                primes.Add(number);
            }
        }

        return primes.ToArray();
    }
}
