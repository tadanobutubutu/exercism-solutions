public class SimpleCipher
{
    private const string Alphabet = "abcdefghijklmnopqrstuvwxyz";
    private static readonly Random Random = new();
    private readonly string key;

    public SimpleCipher()
    {
        key = new string(Enumerable.Range(0, 100).Select(_ => Alphabet[Random.Next(Alphabet.Length)]).ToArray());
    }

    public SimpleCipher(string key)
    {
        if (string.IsNullOrEmpty(key) || key.Any(character => character is < 'a' or > 'z'))
        {
            throw new ArgumentException("The key must contain lowercase letters.", nameof(key));
        }

        this.key = key;
    }
    
    public string Key 
    {
        get
        {
            return key;
        }
    }

    public string Encode(string plaintext)
    {
        return Transform(plaintext, decode: false);
    }

    public string Decode(string ciphertext)
    {
        return Transform(ciphertext, decode: true);
    }

    private string Transform(string input, bool decode)
    {
        var output = new char[input.Length];
        for (var i = 0; i < input.Length; i++)
        {
            var textShift = input[i] - 'a';
            var keyShift = key[i % key.Length] - 'a';
            var shift = decode ? textShift - keyShift : textShift + keyShift;
            output[i] = (char)('a' + (shift + 26) % 26);
        }

        return new string(output);
    }
}
