public class PhoneNumber
{
    public static string Clean(string phoneNumber)
    {
        var digits = new System.Text.StringBuilder();
        foreach (var character in phoneNumber)
        {
            if (char.IsAsciiDigit(character))
            {
                digits.Append(character);
                continue;
            }

            if (character is not ('+' or '(' or ')' or '-' or '.' or ' '))
            {
                throw new ArgumentException("The phone number contains an invalid character.");
            }
        }

        var number = digits.ToString();
        if (number.Length == 11 && number[0] == '1')
        {
            number = number[1..];
        }

        if (number.Length != 10 || number[0] is < '2' or > '9' || number[3] is < '2' or > '9')
        {
            throw new ArgumentException("The phone number is invalid.");
        }

        if (phoneNumber.Contains('+') && (!phoneNumber.StartsWith('+') || phoneNumber.Count(ch => ch == '+') > 1))
        {
            throw new ArgumentException("The country code marker is invalid.");
        }

        return number;
    }
}
