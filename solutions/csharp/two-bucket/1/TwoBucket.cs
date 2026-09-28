public enum Bucket
{
    One,
    Two
}

public class TwoBucketResult
{
    public int Moves { get; set; }
    public Bucket GoalBucket { get; set; }
    public int OtherBucket { get; set; }
}

public class TwoBucket
{
    private readonly int bucketOneSize;
    private readonly int bucketTwoSize;
    private readonly Bucket startBucket;

    public TwoBucket(int bucketOne, int bucketTwo, Bucket startBucket)
    {
        if (bucketOne <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(bucketOne));
        }
        if (bucketTwo <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(bucketTwo));
        }
        if (startBucket is not Bucket.One and not Bucket.Two)
        {
            throw new ArgumentOutOfRangeException(nameof(startBucket));
        }

        bucketOneSize = bucketOne;
        bucketTwoSize = bucketTwo;
        this.startBucket = startBucket;
    }

    public TwoBucketResult Measure(int goal)
    {
        if (goal < 0 || goal > Math.Max(bucketOneSize, bucketTwoSize))
        {
            throw new ArgumentException("The goal cannot be reached with these buckets.", nameof(goal));
        }

        (int One, int Two) initial = startBucket == Bucket.One
            ? (bucketOneSize, 0)
            : (0, bucketTwoSize);
        var pending = new Queue<((int One, int Two) State, int Moves)>();
        var visited = new HashSet<(int One, int Two)> { initial };
        pending.Enqueue((initial, 1));

        while (pending.Count > 0)
        {
            var (state, moves) = pending.Dequeue();
            if (state.One == goal || state.Two == goal)
            {
                Bucket goalBucket = state.One == goal ? Bucket.One : Bucket.Two;
                int other = goalBucket == Bucket.One ? state.Two : state.One;
                return new TwoBucketResult { Moves = moves, GoalBucket = goalBucket, OtherBucket = other };
            }

            foreach (var next in NextStates(state))
            {
                bool forbidden = startBucket == Bucket.One
                    ? next.One == 0 && next.Two == bucketTwoSize
                    : next.Two == 0 && next.One == bucketOneSize;

                if (!forbidden && visited.Add(next))
                {
                    pending.Enqueue((next, moves + 1));
                }
            }
        }

        throw new ArgumentException("The goal cannot be reached with these buckets.", nameof(goal));
    }

    private IEnumerable<(int One, int Two)> NextStates((int One, int Two) state)
    {
        if (state.One > 0)
        {
            yield return (0, state.Two);
        }
        if (state.Two > 0)
        {
            yield return (state.One, 0);
        }
        if (state.One < bucketOneSize)
        {
            yield return (bucketOneSize, state.Two);
        }
        if (state.Two < bucketTwoSize)
        {
            yield return (state.One, bucketTwoSize);
        }

        int toTwo = Math.Min(state.One, bucketTwoSize - state.Two);
        if (toTwo > 0)
        {
            yield return (state.One - toTwo, state.Two + toTwo);
        }

        int toOne = Math.Min(state.Two, bucketOneSize - state.One);
        if (toOne > 0)
        {
            yield return (state.One + toOne, state.Two - toOne);
        }
    }
}
