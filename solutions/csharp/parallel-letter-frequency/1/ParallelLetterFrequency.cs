public static class ParallelLetterFrequency
{
    public static Task<Dictionary<char, int>> Calculate(IEnumerable<string> texts)
    {
        return Task.Run(() =>
        {
            var counts = new System.Collections.Concurrent.ConcurrentDictionary<char, int>();
            Parallel.ForEach(texts, text =>
            {
                foreach (var character in text)
                {
                    if (char.IsLetter(character))
                    {
                        counts.AddOrUpdate(char.ToLowerInvariant(character), 1, (_, count) => count + 1);
                    }
                }
            });

            return counts.ToDictionary(pair => pair.Key, pair => pair.Value);
        });
    }
}
