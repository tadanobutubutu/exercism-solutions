public enum Allergen
{
    Eggs,
    Peanuts,
    Shellfish,
    Strawberries,
    Tomatoes,
    Chocolate,
    Pollen,
    Cats
}

public class Allergies
{
    private readonly int _mask;

    public Allergies(int mask)
    {
        _mask = mask;
    }

    public bool IsAllergicTo(Allergen allergen)
    {
        var value = (int)allergen;
        return value is >= 0 and < 8 && (_mask & (1 << value)) != 0;
    }

    public Allergen[] List()
    {
        return Enum.GetValues<Allergen>()
            .Where(IsAllergicTo)
            .ToArray();
    }
}
