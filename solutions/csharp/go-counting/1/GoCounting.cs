public enum Owner
{
    None,
    Black,
    White
}

public class GoCounting
{
    private readonly Owner[,] board;
    private readonly int width;
    private readonly int height;

    public GoCounting(string input)
    {
        ArgumentNullException.ThrowIfNull(input);
        string[] rows = input.Replace("\r\n", "\n").Split('\n');
        if (rows.Length > 1 && rows[^1].Length == 0)
        {
            rows = rows[..^1];
        }

        height = rows.Length;
        width = height == 0 ? 0 : rows[0].Length;
        if (rows.Any(row => row.Length != width))
        {
            throw new ArgumentException("All rows must have the same width.", nameof(input));
        }

        board = new Owner[height, width];
        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                board[y, x] = rows[y][x] switch
                {
                    'B' => Owner.Black,
                    'W' => Owner.White,
                    ' ' => Owner.None,
                    _ => throw new ArgumentException("The board contains an invalid point.", nameof(input))
                };
            }
        }
    }

    public Tuple<Owner, HashSet<(int, int)>> Territory((int, int) coord)
    {
        var (x, y) = coord;
        ValidateCoordinate(x, y);
        if (board[y, x] != Owner.None)
        {
            return Tuple.Create(Owner.None, new HashSet<(int, int)>());
        }

        HashSet<(int, int)> region = FindRegion((x, y));
        return Tuple.Create(RegionOwner(region), region);
    }

    public Dictionary<Owner, HashSet<(int, int)>> Territories()
    {
        var territories = Enum.GetValues<Owner>()
            .ToDictionary(owner => owner, _ => new HashSet<(int, int)>());
        var visited = new bool[height, width];

        for (int y = 0; y < height; y++)
        {
            for (int x = 0; x < width; x++)
            {
                if (board[y, x] != Owner.None || visited[y, x])
                {
                    continue;
                }

                HashSet<(int, int)> region = FindRegion((x, y));
                foreach (var (regionX, regionY) in region)
                {
                    visited[regionY, regionX] = true;
                }
                territories[RegionOwner(region)].UnionWith(region);
            }
        }

        return territories;
    }

    private HashSet<(int, int)> FindRegion((int X, int Y) start)
    {
        var region = new HashSet<(int, int)> { start };
        var pending = new Queue<(int X, int Y)>();
        pending.Enqueue(start);

        while (pending.Count > 0)
        {
            var (x, y) = pending.Dequeue();
            foreach (var next in Neighbors(x, y))
            {
                if (board[next.Y, next.X] == Owner.None && region.Add((next.X, next.Y)))
                {
                    pending.Enqueue(next);
                }
            }
        }

        return region;
    }

    private Owner RegionOwner(HashSet<(int, int)> region)
    {
        var borderingOwners = new HashSet<Owner>();
        foreach (var (x, y) in region)
        {
            foreach (var next in Neighbors(x, y))
            {
                Owner owner = board[next.Y, next.X];
                if (owner != Owner.None)
                {
                    borderingOwners.Add(owner);
                }
            }
        }

        return borderingOwners.Count == 1 ? borderingOwners.Single() : Owner.None;
    }

    private IEnumerable<(int X, int Y)> Neighbors(int x, int y)
    {
        if (x > 0) yield return (x - 1, y);
        if (x + 1 < width) yield return (x + 1, y);
        if (y > 0) yield return (x, y - 1);
        if (y + 1 < height) yield return (x, y + 1);
    }

    private void ValidateCoordinate(int x, int y)
    {
        if (x < 0 || x >= width || y < 0 || y >= height)
        {
            throw new ArgumentException("The coordinate is outside the board.", nameof(x));
        }
    }
}
