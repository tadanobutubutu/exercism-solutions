public static class RealNumberExtension
{
    public static double Expreal(this int realNumber, RationalNumber r)
    {
        return r.Expreal(realNumber);
    }
}

public struct RationalNumber
{
    private readonly long numerator;
    private readonly long denominator;

    public RationalNumber(int numerator, int denominator)
        : this((long)numerator, denominator)
    {
    }

    private RationalNumber(long numerator, long denominator)
    {
        if (denominator == 0) throw new DivideByZeroException();
        if (denominator < 0)
        {
            numerator = -numerator;
            denominator = -denominator;
        }

        var divisor = GreatestCommonDivisor(Math.Abs(numerator), denominator);
        this.numerator = numerator / divisor;
        this.denominator = denominator / divisor;
    }

    public static RationalNumber operator +(RationalNumber r1, RationalNumber r2)
    {
        return new RationalNumber(r1.numerator * r2.denominator + r2.numerator * r1.denominator, r1.denominator * r2.denominator);
    }

    public static RationalNumber operator -(RationalNumber r1, RationalNumber r2)
    {
        return new RationalNumber(r1.numerator * r2.denominator - r2.numerator * r1.denominator, r1.denominator * r2.denominator);
    }

    public static RationalNumber operator *(RationalNumber r1, RationalNumber r2)
    {
        return new RationalNumber(r1.numerator * r2.numerator, r1.denominator * r2.denominator);
    }

    public static RationalNumber operator /(RationalNumber r1, RationalNumber r2)
    {
        return new RationalNumber(r1.numerator * r2.denominator, r1.denominator * r2.numerator);
    }

    public RationalNumber Abs()
    {
        return new RationalNumber(Math.Abs(numerator), denominator);
    }

    public RationalNumber Reduce()
    {
        return new RationalNumber(numerator, denominator);
    }

    public RationalNumber Exprational(int power)
    {
        if (power == 0) return new RationalNumber(1, 1);
        var exponent = Math.Abs((long)power);
        return power > 0
            ? new RationalNumber(Pow(numerator, exponent), Pow(denominator, exponent))
            : new RationalNumber(Pow(denominator, exponent), Pow(numerator, exponent));
    }

    public double Expreal(int baseNumber)
    {
        return Math.Pow(baseNumber, (double)numerator / denominator);
    }

    private static long GreatestCommonDivisor(long first, long second)
    {
        while (second != 0) (first, second) = (second, first % second);
        return first == 0 ? 1 : first;
    }

    private static long Pow(long value, long power)
    {
        long result = 1;
        while (power > 0)
        {
            if ((power & 1) != 0) result *= value;
            value *= value;
            power >>= 1;
        }

        return result;
    }
}
