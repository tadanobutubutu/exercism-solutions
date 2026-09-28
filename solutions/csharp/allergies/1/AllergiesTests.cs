public class AllergiesTests
{
    [Theory]
    [InlineData(1, Allergen.Eggs)]
    [InlineData(2, Allergen.Peanuts)]
    [InlineData(4, Allergen.Shellfish)]
    [InlineData(8, Allergen.Strawberries)]
    [InlineData(16, Allergen.Tomatoes)]
    [InlineData(32, Allergen.Chocolate)]
    [InlineData(64, Allergen.Pollen)]
    [InlineData(128, Allergen.Cats)]
    public void Detects_single_allergen(int score, Allergen allergen)
    {
        Assert.True(new Allergies(score).IsAllergicTo(allergen));
    }

    [Fact]
    public void Ignores_scores_for_unknown_allergens()
    {
        var allergies = new Allergies(257);
        Assert.True(allergies.IsAllergicTo(Allergen.Eggs));
        Assert.Equal(new[] { Allergen.Eggs }, allergies.List());
    }

    [Fact]
    public void Lists_allergens_in_score_order()
    {
        var allergies = new Allergies(34);
        Assert.Equal(new[] { Allergen.Peanuts, Allergen.Chocolate }, allergies.List());
    }
}
