public static class AllYourBase
{
    public static int[] Rebase(int inputBase, int[] inputDigits, int outputBase)
    {
        if (inputBase < 2 || outputBase < 2)
        {
            throw new ArgumentException("Bases must be at least 2.");
        }

        if (inputDigits.Any(digit => digit < 0 || digit >= inputBase))
        {
            throw new ArgumentException("The input contains a digit outside its base.");
        }

        long value = 0;
        foreach (var digit in inputDigits)
        {
            value = value * inputBase + digit;
        }

        if (value == 0) return [0];

        var result = new List<int>();
        while (value > 0)
        {
            result.Add((int)(value % outputBase));
            value /= outputBase;
        }

        result.Reverse();
        return result.ToArray();
    }
}
