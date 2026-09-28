public static class Luhn
{
    public static bool IsValid(string number)
    {
        ArgumentNullException.ThrowIfNull(number);
        string digits = string.Concat(number.Where(character => character != ' '));
        if (digits.Length <= 1 || digits.Any(character => !char.IsAsciiDigit(character)))
        {
            return false;
        }

        int sum = 0;
        for (int index = 0; index < digits.Length; index++)
        {
            int digit = digits[index] - '0';
            bool doubleDigit = (digits.Length - index) % 2 == 0;
            if (doubleDigit)
            {
                digit *= 2;
                if (digit > 9)
                {
                    digit -= 9;
                }
            }
            sum += digit;
        }

        return sum % 10 == 0;
    }
}
