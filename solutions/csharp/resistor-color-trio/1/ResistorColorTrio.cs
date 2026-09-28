public static class ResistorColorTrio
{
    private static readonly string[] Colors =
        ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"];

    public static string Label(string[] colors)
    {
        if (colors.Length < 3)
        {
            throw new ArgumentException("Three colors are required.");
        }

        var first = Array.IndexOf(Colors, colors[0]);
        var second = Array.IndexOf(Colors, colors[1]);
        var zeroes = Array.IndexOf(Colors, colors[2]);
        if (first < 0 || second < 0 || zeroes < 0)
        {
            throw new ArgumentException("Unknown resistor color.");
        }

        var value = (decimal)(first * 10 + second) * (decimal)Math.Pow(10, zeroes);
        var unit = "ohms";
        if (value >= 1_000_000_000m)
        {
            value /= 1_000_000_000m;
            unit = "gigaohms";
        }
        else if (value >= 1_000_000m)
        {
            value /= 1_000_000m;
            unit = "megaohms";
        }
        else if (value >= 1_000m)
        {
            value /= 1_000m;
            unit = "kiloohms";
        }

        return $"{value.ToString("0.###", System.Globalization.CultureInfo.InvariantCulture)} {unit}";
    }
}
