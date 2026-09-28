public static class Hamming
{
    public static int Distance(string firstStrand, string secondStrand)
    {
        if (firstStrand.Length != secondStrand.Length)
        {
            throw new ArgumentException("The strands must be the same length.");
        }

        var distance = 0;
        for (var index = 0; index < firstStrand.Length; index++)
        {
            if (firstStrand[index] != secondStrand[index])
            {
                distance++;
            }
        }

        return distance;
    }
}
