using System.Globalization;

public enum Location
{
    NewYork,
    London,
    Paris
}

public enum AlertLevel
{
    Early,
    Standard,
    Late
}

public static class Appointment
{
    public static DateTime ShowLocalTime(DateTime dtUtc)
    {
        return TimeZoneInfo.ConvertTimeFromUtc(DateTime.SpecifyKind(dtUtc, DateTimeKind.Utc), TimeZoneInfo.Local);
    }

    public static DateTime Schedule(string appointmentDateDescription, Location location)
    {
        DateTime localTime = DateTime.Parse(appointmentDateDescription, CultureInfo.CurrentCulture);
        return TimeZoneInfo.ConvertTimeToUtc(localTime, GetTimeZone(location));
    }

    public static DateTime GetAlertTime(DateTime appointment, AlertLevel alertLevel)
    {
        TimeSpan leadTime = alertLevel switch
        {
            AlertLevel.Early => TimeSpan.FromDays(1),
            AlertLevel.Standard => TimeSpan.FromMinutes(105),
            AlertLevel.Late => TimeSpan.FromMinutes(30),
            _ => throw new ArgumentOutOfRangeException(nameof(alertLevel))
        };
        return appointment - leadTime;
    }

    public static bool HasDaylightSavingChanged(DateTime dt, Location location)
    {
        TimeZoneInfo zone = GetTimeZone(location);
        DateTime localTime = DateTime.SpecifyKind(dt, DateTimeKind.Unspecified);
        return zone.IsDaylightSavingTime(localTime) != zone.IsDaylightSavingTime(localTime.AddDays(-7));
    }

    public static DateTime NormalizeDateTime(string dtStr, Location location)
    {
        CultureInfo culture = location switch
        {
            Location.NewYork => CultureInfo.GetCultureInfo("en-US"),
            Location.London => CultureInfo.GetCultureInfo("en-GB"),
            Location.Paris => CultureInfo.GetCultureInfo("fr-FR"),
            _ => throw new ArgumentOutOfRangeException(nameof(location))
        };

        return DateTime.TryParse(dtStr, culture, DateTimeStyles.None, out DateTime parsed)
            ? parsed
            : DateTime.MinValue;
    }

    private static TimeZoneInfo GetTimeZone(Location location)
    {
        string zoneId = (location, OperatingSystem.IsWindows()) switch
        {
            (Location.NewYork, true) => "Eastern Standard Time",
            (Location.London, true) => "GMT Standard Time",
            (Location.Paris, true) => "W. Europe Standard Time",
            (Location.NewYork, false) => "America/New_York",
            (Location.London, false) => "Europe/London",
            (Location.Paris, false) => "Europe/Paris",
            _ => throw new ArgumentOutOfRangeException(nameof(location))
        };

        return TimeZoneInfo.FindSystemTimeZoneById(zoneId);
    }
}
