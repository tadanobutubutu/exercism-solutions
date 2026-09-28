public enum Schedule
{
    Teenth,
    First,
    Second,
    Third,
    Fourth,
    Last
}

public class Meetup
{
    private readonly int month;
    private readonly int year;

    public Meetup(int month, int year)
    {
        this.month = month;
        this.year = year;
    }

    public DateTime Day(DayOfWeek dayOfWeek, Schedule schedule)
    {
        var firstOfMonth = new DateTime(year, month, 1);
        var offset = ((int)dayOfWeek - (int)firstOfMonth.DayOfWeek + 7) % 7;
        var firstOccurrence = firstOfMonth.AddDays(offset);

        return schedule switch
        {
            Schedule.Teenth => new DateTime(year, month, 13).AddDays(((int)dayOfWeek - (int)new DateTime(year, month, 13).DayOfWeek + 7) % 7),
            Schedule.First => firstOccurrence,
            Schedule.Second => firstOccurrence.AddDays(7),
            Schedule.Third => firstOccurrence.AddDays(14),
            Schedule.Fourth => firstOccurrence.AddDays(21),
            Schedule.Last => new DateTime(year, month, DateTime.DaysInMonth(year, month)).AddDays(-((int)new DateTime(year, month, DateTime.DaysInMonth(year, month)).DayOfWeek - (int)dayOfWeek + 7) % 7),
            _ => throw new ArgumentOutOfRangeException(nameof(schedule))
        };
    }
}
