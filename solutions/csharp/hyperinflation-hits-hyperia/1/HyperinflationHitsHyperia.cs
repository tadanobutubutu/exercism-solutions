using System.Globalization;

public static class CentralBank
{
    public static string DisplayDenomination(long @base, long multiplier)
    {
        try
        {
            return checked(@base * multiplier).ToString(CultureInfo.InvariantCulture);
        }
        catch (OverflowException)
        {
            return "*** Too Big ***";
        }
    }

    public static string DisplayGDP(float @base, float multiplier)
    {
        float gdp = @base * multiplier;
        return float.IsFinite(gdp) ? gdp.ToString(CultureInfo.InvariantCulture) : "*** Too Big ***";
    }

    public static string DisplayChiefEconomistSalary(decimal salaryBase, decimal multiplier)
    {
        try
        {
            return checked(salaryBase * multiplier).ToString(CultureInfo.InvariantCulture);
        }
        catch (OverflowException)
        {
            return "*** Much Too Big ***";
        }
    }
}
