public static class LargestSeriesProduct
{
    public static long GetLargestProduct(string digits, int span) 
    {
        if (span < 0 || span > digits.Length)
        {
            throw new ArgumentException("The span must be between zero and the input length.");
        }

        if (digits.Any(character => !char.IsAsciiDigit(character)))
        {
            throw new ArgumentException("The input must contain only digits.");
        }

        if (span == 0)
        {
            return 1;
        }

        long largest = 0;
        for (var start = 0; start <= digits.Length - span; start++)
        {
            long product = 1;
            for (var offset = 0; offset < span; offset++)
            {
                product *= digits[start + offset] - '0';
            }

            largest = Math.Max(largest, product);
        }

        return largest;
    }
}
