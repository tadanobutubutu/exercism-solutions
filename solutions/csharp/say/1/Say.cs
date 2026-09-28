public static class Say
{
    private static readonly string[] Ones =
    [
        "zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
        "seventeen", "eighteen", "nineteen"
    ];

    private static readonly string[] Tens =
    ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"];

    private static readonly (long Value, string Name)[] Scales =
    [
        (1_000_000_000, "billion"),
        (1_000_000, "million"),
        (1_000, "thousand")
    ];

    public static string InEnglish(long number)
    {
        if (number is < 0 or > 999_999_999_999)
        {
            throw new ArgumentOutOfRangeException(nameof(number));
        }
        if (number == 0) return Ones[0];

        var parts = new List<string>();
        foreach (var (scale, name) in Scales)
        {
            int group = (int)(number / scale);
            if (group > 0)
            {
                parts.Add(UnderOneThousand(group) + " " + name);
                number %= scale;
            }
        }
        if (number > 0)
        {
            parts.Add(UnderOneThousand((int)number));
        }

        return string.Join(" ", parts);
    }

    private static string UnderOneThousand(int number)
    {
        var parts = new List<string>();
        if (number >= 100)
        {
            parts.Add(Ones[number / 100] + " hundred");
            number %= 100;
        }

        if (number >= 20)
        {
            int tens = number / 10;
            int ones = number % 10;
            parts.Add(ones == 0 ? Tens[tens] : $"{Tens[tens]}-{Ones[ones]}");
        }
        else if (number > 0)
        {
            parts.Add(Ones[number]);
        }

        return string.Join(" ", parts);
    }
}
