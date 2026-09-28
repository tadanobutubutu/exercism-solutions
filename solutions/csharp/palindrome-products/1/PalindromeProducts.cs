public static class PalindromeProducts
{
    public static (int, IEnumerable<(int,int)>) Largest(int minFactor, int maxFactor)
    {
        return Find(minFactor, maxFactor, largest: true);
    }

    public static (int, IEnumerable<(int,int)>) Smallest(int minFactor, int maxFactor)
    {
        return Find(minFactor, maxFactor, largest: false);
    }

    private static (int, IEnumerable<(int, int)>) Find(int minFactor, int maxFactor, bool largest)
    {
        if (minFactor > maxFactor)
        {
            throw new ArgumentException("The minimum factor must not exceed the maximum factor.");
        }

        long best = largest ? long.MinValue : long.MaxValue;
        var factors = new List<(int, int)>();

        if (largest)
        {
            for (int left = maxFactor; left >= minFactor; left--)
            {
                if ((long)left * maxFactor < best)
                {
                    break;
                }

                for (int right = maxFactor; right >= left; right--)
                {
                    long product = (long)left * right;
                    if (product < best)
                    {
                        break;
                    }

                    if (IsPalindrome(product))
                    {
                        if (product > best)
                        {
                            best = product;
                            factors.Clear();
                        }
                        factors.Add((left, right));
                    }
                }
            }
        }
        else
        {
            for (int left = minFactor; left <= maxFactor; left++)
            {
                if ((long)left * left > best)
                {
                    break;
                }

                for (int right = left; right <= maxFactor; right++)
                {
                    long product = (long)left * right;
                    if (product > best)
                    {
                        break;
                    }

                    if (IsPalindrome(product))
                    {
                        if (product < best)
                        {
                            best = product;
                            factors.Clear();
                        }
                        factors.Add((left, right));
                    }
                }
            }
        }

        if (factors.Count == 0 || best < int.MinValue || best > int.MaxValue)
        {
            throw new ArgumentException("No palindrome product exists in the given range.");
        }

        factors.Sort();
        return ((int)best, factors);
    }

    private static bool IsPalindrome(long value)
    {
        if (value < 0)
        {
            return false;
        }

        long original = value;
        long reversed = 0;
        do
        {
            reversed = reversed * 10 + value % 10;
            value /= 10;
        } while (value > 0);

        return original == reversed;
    }
}
