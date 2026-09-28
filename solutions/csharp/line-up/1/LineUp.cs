public static class LineUp
{
    public static string Format(string name, int number)
    {
        int lastTwoDigits = number % 100;
        string suffix = lastTwoDigits is 11 or 12 or 13
            ? "th"
            : (number % 10) switch
            {
                1 => "st",
                2 => "nd",
                3 => "rd",
                _ => "th"
            };

        return $"{name}, you are the {number}{suffix} customer we serve today. Thank you!";
    }
}
