public static class RotationalCipher
{
    public static string Rotate(string text, int shiftKey)
    {
        var shift = ((shiftKey % 26) + 26) % 26;
        var result = new char[text.Length];

        for (var index = 0; index < text.Length; index++)
        {
            var character = text[index];
            result[index] = character switch
            {
                >= 'a' and <= 'z' => (char)('a' + (character - 'a' + shift) % 26),
                >= 'A' and <= 'Z' => (char)('A' + (character - 'A' + shift) % 26),
                _ => character
            };
        }

        return new string(result);
    }
}
