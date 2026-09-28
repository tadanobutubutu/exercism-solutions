public class SpaceAge
{
    private const double EarthYearInSeconds = 31_557_600;
    private readonly int seconds;

    public SpaceAge(int seconds)
    {
        this.seconds = seconds;
    }

    public double OnEarth()
    {
        return AgeOn(1.0);
    }

    public double OnMercury()
    {
        return AgeOn(0.2408467);
    }

    public double OnVenus()
    {
        return AgeOn(0.61519726);
    }

    public double OnMars()
    {
        return AgeOn(1.8808158);
    }

    public double OnJupiter()
    {
        return AgeOn(11.862615);
    }

    public double OnSaturn()
    {
        return AgeOn(29.447498);
    }

    public double OnUranus()
    {
        return AgeOn(84.016846);
    }

    public double OnNeptune()
    {
        return AgeOn(164.79132);
    }

    private double AgeOn(double orbitalPeriod) => seconds / (EarthYearInSeconds * orbitalPeriod);
}
