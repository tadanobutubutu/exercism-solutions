public class RailFenceCipher
{
    private readonly int rails;

    public RailFenceCipher(int rails)
    {
        if (rails < 1)
        {
            throw new ArgumentOutOfRangeException(nameof(rails));
        }
        this.rails = rails;
    }

    public string Encode(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        if (rails == 1 || input.Length <= 1) return input;

        var rows = Enumerable.Range(0, rails).Select(_ => new System.Text.StringBuilder()).ToArray();
        int rail = 0;
        int direction = 1;
        foreach (char character in input)
        {
            rows[rail].Append(character);
            if (rail == 0) direction = 1;
            else if (rail == rails - 1) direction = -1;
            rail += direction;
        }

        return string.Concat(rows.Select(row => row.ToString()));
    }

    public string Decode(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        if (rails == 1 || input.Length <= 1) return input;

        int[] railForPosition = new int[input.Length];
        int[] counts = new int[rails];
        int rail = 0;
        int direction = 1;
        for (int index = 0; index < input.Length; index++)
        {
            railForPosition[index] = rail;
            counts[rail]++;
            if (rail == 0) direction = 1;
            else if (rail == rails - 1) direction = -1;
            rail += direction;
        }

        var railContents = new Queue<char>[rails];
        int offset = 0;
        for (int index = 0; index < rails; index++)
        {
            railContents[index] = new Queue<char>(input.Skip(offset).Take(counts[index]));
            offset += counts[index];
        }

        var decoded = new char[input.Length];
        for (int index = 0; index < input.Length; index++)
        {
            decoded[index] = railContents[railForPosition[index]].Dequeue();
        }

        return new string(decoded);
    }
}
