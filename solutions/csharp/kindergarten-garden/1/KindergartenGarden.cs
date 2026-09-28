public enum Plant
{
    Violets,
    Radishes,
    Clover,
    Grass
}

public class KindergartenGarden
{
    private readonly string[] rows;
    private static readonly string[] Students =
    [
        "Alice", "Bob", "Charlie", "David", "Eve", "Fred",
        "Ginny", "Harriet", "Ileana", "Joseph", "Kincaid", "Larry"
    ];

    public KindergartenGarden(string diagram)
    {
        rows = diagram.Split('\n').Select(row => row.TrimEnd('\r')).ToArray();
    }

    public IEnumerable<Plant> Plants(string student)
    {
        var studentIndex = Array.IndexOf(Students, student);
        if (studentIndex < 0) throw new ArgumentException("Unknown student.", nameof(student));

        var firstCup = studentIndex * 2;
        return rows.SelectMany(row => row.Skip(firstCup).Take(2)).Select(DecodePlant).ToArray();
    }

    private static Plant DecodePlant(char plant) => plant switch
    {
        'V' => Plant.Violets,
        'R' => Plant.Radishes,
        'C' => Plant.Clover,
        'G' => Plant.Grass,
        _ => throw new ArgumentException("Unknown plant.", nameof(plant))
    };
}
