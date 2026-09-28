public static class ProteinTranslation
{
    public static string[] Proteins(string strand)
    {
        var proteins = new List<string>();

        for (var index = 0; index + 2 < strand.Length; index += 3)
        {
            var protein = strand.Substring(index, 3) switch
            {
                "AUG" => "Methionine",
                "UUU" or "UUC" => "Phenylalanine",
                "UUA" or "UUG" => "Leucine",
                "UCU" or "UCC" or "UCA" or "UCG" => "Serine",
                "UAU" or "UAC" => "Tyrosine",
                "UGU" or "UGC" => "Cysteine",
                "UGG" => "Tryptophan",
                "UAA" or "UAG" or "UGA" => null,
                _ => throw new ArgumentException("Unknown RNA codon.")
            };

            if (protein is null)
            {
                break;
            }

            proteins.Add(protein);
        }

        return proteins.ToArray();
    }
}
