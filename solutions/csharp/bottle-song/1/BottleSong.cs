using System.Collections.Generic;

public static class BottleSong
{
    public static IEnumerable<string> Recite(int startBottles, int takeDown)
    {
        var lyrics = new List<string>();

        for (var verse = 0; verse < takeDown; verse++)
        {
            var bottles = startBottles - verse;
            var number = bottles switch
            {
                0 => "no",
                1 => "One",
                2 => "Two",
                3 => "Three",
                4 => "Four",
                5 => "Five",
                6 => "Six",
                7 => "Seven",
                8 => "Eight",
                9 => "Nine",
                10 => "Ten",
                _ => bottles.ToString()
            };
            var noun = bottles == 1 ? "bottle" : "bottles";

            if (verse > 0)
            {
                lyrics.Add("");
            }

            lyrics.Add($"{number} green {noun} hanging on the wall,");
            lyrics.Add($"{number} green {noun} hanging on the wall,");
            lyrics.Add("And if one green bottle should accidentally fall,");

            var remaining = bottles - 1;
            var remainingNumber = remaining switch
            {
                0 => "no",
                1 => "one",
                2 => "two",
                3 => "three",
                4 => "four",
                5 => "five",
                6 => "six",
                7 => "seven",
                8 => "eight",
                9 => "nine",
                _ => remaining.ToString()
            };
            var remainingNoun = remaining == 1 ? "bottle" : "bottles";
            lyrics.Add($"There'll be {remainingNumber} green {remainingNoun} hanging on the wall.");
        }

        return lyrics;
    }
}
