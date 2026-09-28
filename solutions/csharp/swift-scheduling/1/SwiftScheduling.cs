public static class SwiftScheduling
{
    public static DateTime DeliveryDate(DateTime meetingStart, string description)
    {
        ArgumentNullException.ThrowIfNull(description);

        if (description == "NOW") return meetingStart.AddHours(2);
        if (description == "ASAP")
            return meetingStart.TimeOfDay < TimeSpan.FromHours(13)
                ? meetingStart.Date.AddHours(17)
                : meetingStart.Date.AddDays(1).AddHours(13);

        if (description == "EOW")
        {
            if (meetingStart.DayOfWeek is DayOfWeek.Monday or DayOfWeek.Tuesday or DayOfWeek.Wednesday)
            {
                int daysUntilFriday = ((int)DayOfWeek.Friday - (int)meetingStart.DayOfWeek + 7) % 7;
                return meetingStart.Date.AddDays(daysUntilFriday).AddHours(17);
            }

            int daysUntilSunday = ((int)DayOfWeek.Sunday - (int)meetingStart.DayOfWeek + 7) % 7;
            return meetingStart.Date.AddDays(daysUntilSunday).AddHours(20);
        }

        if (description.StartsWith('Q') && int.TryParse(description.AsSpan(1), out int quarter)
            && quarter is >= 1 and <= 4)
        {
            int currentQuarter = (meetingStart.Month - 1) / 3 + 1;
            int year = quarter >= currentQuarter ? meetingStart.Year : meetingStart.Year + 1;
            int month = quarter * 3;
            DateTime lastDay = new(year, month, DateTime.DaysInMonth(year, month));
            while (lastDay.DayOfWeek is DayOfWeek.Saturday or DayOfWeek.Sunday)
                lastDay = lastDay.AddDays(-1);
            return lastDay.AddHours(8);
        }

        if (description.EndsWith('M') && int.TryParse(description.AsSpan(0, description.Length - 1), out int monthNumber)
            && monthNumber is >= 1 and <= 12)
        {
            int year = monthNumber > meetingStart.Month ? meetingStart.Year : meetingStart.Year + 1;
            DateTime firstDay = new(year, monthNumber, 1);
            while (firstDay.DayOfWeek is DayOfWeek.Saturday or DayOfWeek.Sunday)
                firstDay = firstDay.AddDays(1);
            return firstDay.AddHours(8);
        }

        throw new ArgumentException("Unknown delivery date description.", nameof(description));
    }
}
