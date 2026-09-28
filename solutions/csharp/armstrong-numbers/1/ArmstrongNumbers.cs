public static class ArmstrongNumbers
{
    public static bool IsArmstrongNumber(int number)
    {
        if (number < 0)
        {
            return false;
        }

        var digits = number.ToString().Select(character => character - '0').ToArray();
        var power = digits.Length;
        long sum = 0;

        foreach (var digit in digits)
        {
            long poweredDigit = 1;
            for (var exponent = 0; exponent < power; exponent++)
            {
                poweredDigit *= digit;
            }

            sum += poweredDigit;
        }

        return sum == number;
    }
}
