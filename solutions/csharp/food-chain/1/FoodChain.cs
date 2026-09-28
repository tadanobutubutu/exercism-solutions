public static class FoodChain
{
    private static readonly string[] Animals = ["fly", "spider", "bird", "cat", "dog", "goat", "cow", "horse"];
    private static readonly string[] Descriptions =
    [
        "",
        "It wriggled and jiggled and tickled inside her.",
        "How absurd to swallow a bird!",
        "Imagine that, to swallow a cat!",
        "What a hog, to swallow a dog!",
        "Just opened her throat and swallowed a goat!",
        "I don't know how she swallowed a cow!",
        "She's dead, of course!"
    ];

    public static string Recite(int verseNumber)
    {
        return Recite(verseNumber, verseNumber);
    }

    public static string Recite(int startVerse, int endVerse)
    {
        return string.Join("\n\n", Enumerable.Range(startVerse, endVerse - startVerse + 1).Select(Verse));
    }

    private static string Verse(int number)
    {
        var lines = new List<string> { $"I know an old lady who swallowed a {Animals[number - 1]}." };
        if (number == Animals.Length)
        {
            lines.Add(Descriptions[number - 1]);
            return string.Join('\n', lines);
        }

        if (number > 1) lines.Add(Descriptions[number - 1]);
        for (var animal = number - 1; animal > 0; animal--)
        {
            var target = Animals[animal - 1];
            var extra = animal == 2 ? " that wriggled and jiggled and tickled inside her" : "";
            lines.Add($"She swallowed the {Animals[animal]} to catch the {target}{extra}.");
        }

        lines.Add("I don't know why she swallowed the fly. Perhaps she'll die.");
        return string.Join('\n', lines);
    }
}
