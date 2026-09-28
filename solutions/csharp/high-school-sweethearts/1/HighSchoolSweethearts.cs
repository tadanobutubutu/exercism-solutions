using System.Globalization;

public static class HighSchoolSweethearts
{
    public static string DisplaySingleLine(string studentA, string studentB)
    {
        string couple = $"{studentA} ♡ {studentB}";
        return couple.PadLeft(30 + couple.Length / 2).PadRight(61);
    }

    public static string DisplayBanner(string studentA, string studentB)
    {
        return $@"
     ******       ******
   **      **   **      **
 **         ** **         **
**            *            **
**                         **
**     {studentA} +  {studentB}    **
 **                       **
   **                   **
     **               **
       **           **
         **       **
           **   **
             ***
              *";
    }

    public static string DisplayGermanExchangeStudents(string studentA
        , string studentB, DateTime start, float hours)
    {
        CultureInfo germanCulture = CultureInfo.GetCultureInfo("de-DE");
        return string.Format(germanCulture,
            "{0} and {1} have been dating since {2:d} - that's {3:n2} hours",
            studentA, studentB, start, hours);
    }
}
