public static class ResistorColorDuo
{
    private static readonly string[] Colors =
        ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"];

    public static int Value(string[] colors)
    {
        if (colors.Length < 2)
        {
            throw new ArgumentException("At least two colors are required.");
        }

        var first = Array.IndexOf(Colors, colors[0]);
        var second = Array.IndexOf(Colors, colors[1]);
        if (first < 0 || second < 0)
        {
            throw new ArgumentException("Unknown resistor color.");
        }

        return first * 10 + second;
    }
}
