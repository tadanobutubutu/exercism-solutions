public static class AffineCipher
{
    public static string Encode(string plainText, int a, int b)
    {
        ValidateKey(a);
        ArgumentNullException.ThrowIfNull(plainText);

        var encoded = new List<char>();
        foreach (char character in plainText)
        {
            if (char.IsAsciiLetter(character))
            {
                int value = char.ToLowerInvariant(character) - 'a';
                encoded.Add((char)('a' + Mod(a * value + b, 26)));
            }
            else if (char.IsAsciiDigit(character))
            {
                encoded.Add(character);
            }
        }

        return string.Join(" ", encoded.Chunk(5).Select(chunk => new string(chunk)));
    }

    public static string Decode(string cipheredText, int a, int b)
    {
        ValidateKey(a);
        ArgumentNullException.ThrowIfNull(cipheredText);

        int inverse = Enumerable.Range(0, 26).Single(value => Mod(a * value, 26) == 1);
        var decoded = new List<char>();
        foreach (char character in cipheredText)
        {
            if (char.IsAsciiLetter(character))
            {
                int value = char.ToLowerInvariant(character) - 'a';
                decoded.Add((char)('a' + Mod(inverse * (value - b), 26)));
            }
            else if (char.IsAsciiDigit(character))
            {
                decoded.Add(character);
            }
        }

        return new string(decoded.ToArray());
    }

    private static void ValidateKey(int a)
    {
        if (GreatestCommonDivisor(Mod(a, 26), 26) != 1)
        {
            throw new ArgumentException("The key value must be coprime with 26.", nameof(a));
        }
    }

    private static int GreatestCommonDivisor(int left, int right)
    {
        while (right != 0)
        {
            (left, right) = (right, left % right);
        }
        return left;
    }

    private static int Mod(int value, int modulus) => (value % modulus + modulus) % modulus;
}
