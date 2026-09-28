public enum Color { Red, Green, Ivory, Yellow, Blue }
public enum Nationality { Englishman, Spaniard, Ukrainian, Japanese, Norwegian }
public enum Pet { Dog, Snails, Fox, Horse, Zebra }
public enum Drink { Coffee, Tea, Milk, OrangeJuice, Water }
public enum Smoke { OldGold, Kools, Chesterfields, LuckyStrike, Parliaments }

public static class ZebraPuzzle
{
    private static readonly (Nationality Water, Nationality Zebra) Solution = FindSolution();

    public static Nationality DrinksWater() => Solution.Water;
    public static Nationality OwnsZebra() => Solution.Zebra;

    private static (Nationality Water, Nationality Zebra) FindSolution()
    {
        int[][] permutations = Permutations().ToArray();
        foreach (int[] colors in permutations)
        {
            if (colors[(int)Color.Green] != colors[(int)Color.Ivory] + 1) continue;

            foreach (int[] nationalities in permutations)
            {
                if (nationalities[(int)Nationality.Englishman] != colors[(int)Color.Red]
                    || nationalities[(int)Nationality.Norwegian] != 0
                    || Math.Abs(nationalities[(int)Nationality.Norwegian] - colors[(int)Color.Blue]) != 1)
                    continue;

                foreach (int[] drinks in permutations)
                {
                    if (drinks[(int)Drink.Coffee] != colors[(int)Color.Green]
                        || drinks[(int)Drink.Tea] != nationalities[(int)Nationality.Ukrainian]
                        || drinks[(int)Drink.Milk] != 2)
                        continue;

                    foreach (int[] smokes in permutations)
                    {
                        if (colors[(int)Color.Yellow] != smokes[(int)Smoke.Kools]
                            || drinks[(int)Drink.OrangeJuice] != smokes[(int)Smoke.LuckyStrike]
                            || nationalities[(int)Nationality.Japanese] != smokes[(int)Smoke.Parliaments])
                            continue;

                        foreach (int[] pets in permutations)
                        {
                            if (pets[(int)Pet.Dog] != nationalities[(int)Nationality.Spaniard]
                                || pets[(int)Pet.Snails] != smokes[(int)Smoke.OldGold]
                                || Math.Abs(smokes[(int)Smoke.Chesterfields] - pets[(int)Pet.Fox]) != 1
                                || Math.Abs(smokes[(int)Smoke.Kools] - pets[(int)Pet.Horse]) != 1)
                                continue;

                            int waterHouse = drinks[(int)Drink.Water];
                            int zebraHouse = pets[(int)Pet.Zebra];
                            return (
                                (Nationality)Array.IndexOf(nationalities, waterHouse),
                                (Nationality)Array.IndexOf(nationalities, zebraHouse));
                        }
                    }
                }
            }
        }

        throw new InvalidOperationException("No solution exists for the puzzle.");
    }

    private static IEnumerable<int[]> Permutations()
    {
        int[] positions = new int[5];
        bool[] used = new bool[5];

        IEnumerable<int[]> Generate(int value)
        {
            if (value == positions.Length)
            {
                yield return (int[])positions.Clone();
                yield break;
            }

            for (int position = 0; position < positions.Length; position++)
            {
                if (used[position]) continue;
                used[position] = true;
                positions[value] = position;
                foreach (int[] permutation in Generate(value + 1)) yield return permutation;
                used[position] = false;
            }
        }

        return Generate(0);
    }
}
