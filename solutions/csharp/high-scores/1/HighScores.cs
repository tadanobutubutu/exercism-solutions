public class HighScores
{
    private readonly List<int> _scores;

    public HighScores(List<int> list)
    {
        _scores = new List<int>(list);
    }

    public List<int> Scores()
    {
        return new List<int>(_scores);
    }

    public int Latest()
    {
        return _scores[^1];
    }

    public int PersonalBest()
    {
        return _scores.Max();
    }

    public List<int> PersonalTopThree()
    {
        return _scores.OrderByDescending(score => score).Take(3).ToList();
    }
}
