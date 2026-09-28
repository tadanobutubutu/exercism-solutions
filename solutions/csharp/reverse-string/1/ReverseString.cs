public static class ReverseString
{
    public static string Reverse(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        return new string(input.Reverse().ToArray());
    }
}
