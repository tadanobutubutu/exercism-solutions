public enum Classification
{
    Perfect,
    Abundant,
    Deficient
}

public static class PerfectNumbers
{
    public static Classification Classify(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(number));
        }

        long aliquotSum = 0;
        for (var divisor = 1; divisor <= number / divisor; divisor++)
        {
            if (number % divisor != 0)
            {
                continue;
            }

            var pairedDivisor = number / divisor;
            if (divisor != number)
            {
                aliquotSum += divisor;
            }
            if (pairedDivisor != number && pairedDivisor != divisor)
            {
                aliquotSum += pairedDivisor;
            }
        }

        if (aliquotSum == number)
        {
            return Classification.Perfect;
        }

        return aliquotSum > number ? Classification.Abundant : Classification.Deficient;
    }
}
