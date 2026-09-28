public static class BafflingBirthdays
{
    public static DateOnly[] RandomBirthdates(int numberOfBirthdays)
    {
        ArgumentOutOfRangeException.ThrowIfNegative(numberOfBirthdays);

        var birthdates = new DateOnly[numberOfBirthdays];
        for (int index = 0; index < numberOfBirthdays; index++)
        {
            int year;
            do
            {
                year = Random.Shared.Next(1900, 2101);
            } while (DateTime.IsLeapYear(year));

            int dayOfYear = Random.Shared.Next(365);
            birthdates[index] = new DateOnly(year, 1, 1).AddDays(dayOfYear);
        }
        return birthdates;
    }

    public static bool SharedBirthday(DateOnly[] birthdays)
    {
        ArgumentNullException.ThrowIfNull(birthdays);
        return birthdays
            .GroupBy(date => (date.Month, date.Day))
            .Any(group => group.Count() > 1);
    }
    
    public static double EstimatedProbabilityOfSharedBirthday(int numberOfBirthdays)
    {
        ArgumentOutOfRangeException.ThrowIfNegative(numberOfBirthdays);
        if (numberOfBirthdays <= 1) return 0.0;
        if (numberOfBirthdays > 365) return 100.0;

        double noSharedBirthdayProbability = 1.0;
        for (int day = 0; day < numberOfBirthdays; day++)
            noSharedBirthdayProbability *= (365.0 - day) / 365.0;

        return (1.0 - noSharedBirthdayProbability) * 100.0;
    }
}
