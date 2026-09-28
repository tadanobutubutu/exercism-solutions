public class Clock
{
    private const int MinutesPerDay = 24 * 60;
    private readonly int minutesSinceMidnight;

    public Clock(int hours, int minutes)
    {
        minutesSinceMidnight = Mod(hours * 60 + minutes, MinutesPerDay);
    }

    public Clock Add(int minutesToAdd)
    {
        return new Clock(0, minutesSinceMidnight + minutesToAdd);
    }

    public Clock Subtract(int minutesToSubtract)
    {
        return new Clock(0, minutesSinceMidnight - minutesToSubtract);
    }

    public override string ToString() => $"{minutesSinceMidnight / 60:00}:{minutesSinceMidnight % 60:00}";

    public override bool Equals(object? obj) => obj is Clock other && minutesSinceMidnight == other.minutesSinceMidnight;

    public override int GetHashCode() => minutesSinceMidnight;

    private static int Mod(int value, int modulus) => (value % modulus + modulus) % modulus;
}
