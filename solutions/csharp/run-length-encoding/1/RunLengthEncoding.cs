public static class RunLengthEncoding
{
    public static string Encode(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        if (input.Length == 0) return string.Empty;

        var encoded = new System.Text.StringBuilder();
        for (int start = 0; start < input.Length;)
        {
            int end = start + 1;
            while (end < input.Length && input[end] == input[start]) end++;
            int count = end - start;
            if (count > 1) encoded.Append(count);
            encoded.Append(input[start]);
            start = end;
        }

        return encoded.ToString();
    }

    public static string Decode(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        var decoded = new System.Text.StringBuilder();
        int index = 0;
        while (index < input.Length)
        {
            int count = 0;
            bool hasCount = false;
            while (index < input.Length && char.IsAsciiDigit(input[index]))
            {
                hasCount = true;
                count = checked(count * 10 + input[index] - '0');
                index++;
            }

            if (index == input.Length)
            {
                break;
            }

            char value = input[index++];
            decoded.Append(value, hasCount ? count : 1);
        }

        return decoded.ToString();
    }
}
