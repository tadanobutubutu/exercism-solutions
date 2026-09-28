public struct Coord
{
    public Coord(ushort x, ushort y)
    {
        X = x;
        Y = y;
    }

    public ushort X { get; }
    public ushort Y { get; }
}

public struct Plot : IEquatable<Plot>
{
    private readonly Coord first;
    private readonly Coord second;
    private readonly Coord third;
    private readonly Coord fourth;

    public Plot(Coord coord1, Coord coord2, Coord coord3, Coord coord4)
    {
        Coord[] coordinates = [coord1, coord2, coord3, coord4];
        Array.Sort(coordinates, (left, right) =>
        {
            int xComparison = left.X.CompareTo(right.X);
            return xComparison != 0 ? xComparison : left.Y.CompareTo(right.Y);
        });

        first = coordinates[0];
        second = coordinates[1];
        third = coordinates[2];
        fourth = coordinates[3];
    }

    public bool Equals(Plot other) =>
        first.Equals(other.first) && second.Equals(other.second) &&
        third.Equals(other.third) && fourth.Equals(other.fourth);

    public override bool Equals(object? obj) => obj is Plot other && Equals(other);

    public override int GetHashCode() => HashCode.Combine(first, second, third, fourth);

    public int LongestSide
    {
        get
        {
            ushort minX = Math.Min(Math.Min(first.X, second.X), Math.Min(third.X, fourth.X));
            ushort maxX = Math.Max(Math.Max(first.X, second.X), Math.Max(third.X, fourth.X));
            ushort minY = Math.Min(Math.Min(first.Y, second.Y), Math.Min(third.Y, fourth.Y));
            ushort maxY = Math.Max(Math.Max(first.Y, second.Y), Math.Max(third.Y, fourth.Y));
            return Math.Max(maxX - minX, maxY - minY);
        }
    }
}


public class ClaimsHandler
{
    private readonly HashSet<Plot> claims = new();
    private Plot lastClaim;
    private bool hasLastClaim;

    public void StakeClaim(Plot plot)
    {
        claims.Add(plot);
        lastClaim = plot;
        hasLastClaim = true;
    }

    public bool IsClaimStaked(Plot plot)
    {
        return claims.Contains(plot);
    }

    public bool IsLastClaim(Plot plot)
    {
        return hasLastClaim && lastClaim.Equals(plot);
    }

    public Plot GetClaimWithLongestSide()
    {
        using var enumerator = claims.GetEnumerator();
        if (!enumerator.MoveNext())
        {
            throw new InvalidOperationException("No claims have been staked.");
        }

        Plot longest = enumerator.Current;
        while (enumerator.MoveNext())
        {
            if (enumerator.Current.LongestSide > longest.LongestSide)
            {
                longest = enumerator.Current;
            }
        }

        return longest;
    }
}
