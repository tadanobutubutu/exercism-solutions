public static class NucleotideCount
{
    public static IDictionary<char, int> Count(string sequence)
    {
        var counts = new Dictionary<char, int>
        {
            ['A'] = 0,
            ['C'] = 0,
            ['G'] = 0,
            ['T'] = 0
        };

        foreach (var nucleotide in sequence)
        {
            if (!counts.ContainsKey(nucleotide))
            {
                throw new ArgumentException($"Invalid nucleotide: {nucleotide}.");
            }

            counts[nucleotide]++;
        }

        return counts;
    }
}
