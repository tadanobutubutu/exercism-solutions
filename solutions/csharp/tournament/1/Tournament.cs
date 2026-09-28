using System.Text;

public static class Tournament
{   
    public static void Tally(Stream inStream, Stream outStream)
    {
        var teams = new Dictionary<string, TeamStats>();
        using (var reader = new StreamReader(inStream, Encoding.UTF8, true, 1024, true))
        {
            string? line;
            while ((line = reader.ReadLine()) is not null)
            {
                if (line.Length == 0) continue;
                var fields = line.Split(';');
                var first = GetTeam(teams, fields[0]);
                var second = GetTeam(teams, fields[1]);
                first.Matches++;
                second.Matches++;

                switch (fields[2])
                {
                    case "win":
                        first.Wins++;
                        second.Losses++;
                        break;
                    case "loss":
                        first.Losses++;
                        second.Wins++;
                        break;
                    case "draw":
                        first.Draws++;
                        second.Draws++;
                        break;
                }
            }
        }

        var output = new StringBuilder("Team                           | MP |  W |  D |  L |  P");
        foreach (var (name, stats) in teams.OrderByDescending(pair => pair.Value.Points).ThenBy(pair => pair.Key, StringComparer.Ordinal))
        {
            output.Append('\n').AppendFormat(
                "{0,-31}| {1,2} | {2,2} | {3,2} | {4,2} | {5,2}",
                name, stats.Matches, stats.Wins, stats.Draws, stats.Losses, stats.Points);
        }

        using var writer = new StreamWriter(outStream, new UTF8Encoding(false), 1024, true);
        writer.Write(output.ToString());
        writer.Flush();
    }

    private static TeamStats GetTeam(Dictionary<string, TeamStats> teams, string name)
    {
        if (!teams.TryGetValue(name, out var stats))
        {
            stats = new TeamStats();
            teams.Add(name, stats);
        }

        return stats;
    }

    private sealed class TeamStats
    {
        public int Matches { get; set; }
        public int Wins { get; set; }
        public int Draws { get; set; }
        public int Losses { get; set; }
        public int Points => Wins * 3 + Draws;
    }
}
