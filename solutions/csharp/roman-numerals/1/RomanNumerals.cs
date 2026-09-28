public static class RomanNumeralExtension
{
    public static string ToRoman(this int value)
    {
        var numerals = new (int Value, string Numeral)[]
        {
            (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
            (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
            (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
        };

        var result = new System.Text.StringBuilder();
        foreach (var (number, numeral) in numerals)
        {
            while (value >= number)
            {
                result.Append(numeral);
                value -= number;
            }
        }

        return result.ToString();
    }
}
