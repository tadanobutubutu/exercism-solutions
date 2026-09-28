public static class PythagoreanTriplet
{
    public static IEnumerable<(int a, int b, int c)> TripletsWithSum(int sum)
    {
        var triplets = new List<(int a, int b, int c)>();
        if (sum <= 0) return triplets;

        for (long m = 2; 2 * m * (m + 1) <= sum; m++)
        {
            for (long n = 1; n < m; n++)
            {
                if (((m - n) & 1) == 0 || GreatestCommonDivisor(m, n) != 1) continue;

                var primitivePerimeter = 2 * m * (m + n);
                if (sum % primitivePerimeter != 0) continue;

                var scale = sum / primitivePerimeter;
                var first = scale * (m * m - n * n);
                var second = scale * 2 * m * n;
                var a = (int)Math.Min(first, second);
                var b = (int)Math.Max(first, second);
                var c = (int)(scale * (m * m + n * n));
                triplets.Add((a, b, c));
            }
        }

        return triplets.OrderBy(triplet => triplet.a).ThenBy(triplet => triplet.b).ToArray();
    }

    private static long GreatestCommonDivisor(long first, long second)
    {
        while (second != 0) (first, second) = (second, first % second);
        return first;
    }
}
