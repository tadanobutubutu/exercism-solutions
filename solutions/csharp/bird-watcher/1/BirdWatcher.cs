class BirdCount
{
    private int[] birdsPerDay;

    public BirdCount(int[] birdsPerDay)
    {
        this.birdsPerDay = birdsPerDay;
    }

    public static int[] LastWeek()
    {
        return new[] { 0, 2, 5, 3, 7, 8, 4 };
    }

    public int Today()
    {
        return birdsPerDay[^1];
    }

    public void IncrementTodaysCount()
    {
        birdsPerDay[^1]++;
    }

    public bool HasDayWithoutBirds()
    {
        return Array.IndexOf(birdsPerDay, 0) >= 0;
    }

    public int CountForFirstDays(int numberOfDays)
    {
        var total = 0;
        for (var day = 0; day < Math.Min(numberOfDays, birdsPerDay.Length); day++)
        {
            total += birdsPerDay[day];
        }
        return total;
    }

    public int BusyDays()
    {
        var busyDays = 0;
        foreach (var count in birdsPerDay)
        {
            if (count >= 5) busyDays++;
        }
        return busyDays;
    }
}
