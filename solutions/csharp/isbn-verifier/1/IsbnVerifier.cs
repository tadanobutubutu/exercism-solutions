public static class IsbnVerifier
{
    public static bool IsValid(string number)
    {
        ArgumentNullException.ThrowIfNull(number);
        string compact = number.Replace("-", string.Empty, StringComparison.Ordinal);
        if (compact.Length != 10)
        {
            return false;
        }

        int sum = 0;
        for (int index = 0; index < compact.Length; index++)
        {
            int digit;
            if (index == compact.Length - 1 && compact[index] == 'X')
            {
                digit = 10;
            }
            else if (char.IsAsciiDigit(compact[index]))
            {
                digit = compact[index] - '0';
            }
            else
            {
                return false;
            }

            sum += digit * (10 - index);
        }

        return sum % 11 == 0;
    }
}
