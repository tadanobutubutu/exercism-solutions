public static class RnaTranscription
{
    public static string ToRna(string strand)
    {
        ArgumentNullException.ThrowIfNull(strand);
        var transcript = new System.Text.StringBuilder(strand.Length);
        foreach (char nucleotide in strand)
        {
            transcript.Append(nucleotide switch
            {
                'G' => 'C',
                'C' => 'G',
                'T' => 'A',
                'A' => 'U',
                _ => throw new ArgumentException("The strand contains an invalid nucleotide.", nameof(strand))
            });
        }
        return transcript.ToString();
    }
}
