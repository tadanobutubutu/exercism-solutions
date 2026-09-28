public static class House
{
    private static readonly string[] Subjects =
    [
        "the house",
        "the malt",
        "the rat",
        "the cat",
        "the dog",
        "the cow with the crumpled horn",
        "the maiden all forlorn",
        "the man all tattered and torn",
        "the priest all shaven and shorn",
        "the rooster that crowed in the morn",
        "the farmer sowing his corn",
        "the horse and the hound and the horn"
    ];

    private static readonly string[] Links =
    [
        "that Jack built.",
        "that lay in",
        "that ate",
        "that killed",
        "that worried",
        "that tossed",
        "that milked",
        "that kissed",
        "that married",
        "that woke",
        "that kept",
        "that belonged to"
    ];

    public static string Recite(int verseNumber)
    {
        if (verseNumber is < 1 or > 12)
        {
            throw new ArgumentOutOfRangeException(nameof(verseNumber));
        }

        var verse = $"This is {Subjects[verseNumber - 1]}";
        for (var index = verseNumber - 1; index > 0; index--)
        {
            verse += $" {Links[index]} {Subjects[index - 1]}";
        }

        return $"{verse} {Links[0]}";
    }

    public static string Recite(int startVerse, int endVerse)
    {
        if (startVerse < 1 || endVerse > 12 || startVerse > endVerse)
        {
            throw new ArgumentOutOfRangeException(nameof(startVerse));
        }

        return string.Join("\n", Enumerable.Range(startVerse, endVerse - startVerse + 1).Select(verse => Recite(verse)));
    }
}
