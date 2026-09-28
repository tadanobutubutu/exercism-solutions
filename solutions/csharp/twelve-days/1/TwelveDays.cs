public static class TwelveDays
{
    private static readonly string[] Ordinals =
    [
        "first", "second", "third", "fourth", "fifth", "sixth",
        "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"
    ];

    private static readonly string[] Gifts =
    [
        "a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens",
        "four Calling Birds", "five Gold Rings", "six Geese-a-Laying",
        "seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing",
        "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"
    ];

    public static string Recite(int verseNumber)
    {
        if (verseNumber < 1 || verseNumber > Gifts.Length)
        {
            return string.Empty;
        }

        var gifts = new List<string>();
        for (int index = verseNumber - 1; index >= 1; index--)
        {
            gifts.Add(Gifts[index]);
        }

        string list = gifts.Count == 0
            ? Gifts[0]
            : string.Join(", ", gifts) + ", and " + Gifts[0];
        return $"On the {Ordinals[verseNumber - 1]} day of Christmas my true love gave to me: {list}.";
    }

    public static string Recite(int startVerse, int endVerse)
    {
        if (startVerse < 1 || endVerse > Gifts.Length || startVerse > endVerse)
        {
            return string.Empty;
        }

        return string.Join("\n", Enumerable.Range(startVerse, endVerse - startVerse + 1).Select(verse => Recite(verse)));
    }
}
