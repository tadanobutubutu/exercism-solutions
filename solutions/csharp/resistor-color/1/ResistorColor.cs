public static class ResistorColor
{
    private static readonly string[] colorNames =
    ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"];

    public static int ColorCode(string color)
    {
        return Array.IndexOf(colorNames, color);
    }

    public static string[] Colors()
    {
        return (string[])colorNames.Clone();
    }
}
