public enum SublistType
{
    Equal,
    Unequal,
    Superlist,
    Sublist
}

public static class Sublist
{
    public static SublistType Classify<T>(List<T> list1, List<T> list2)
        where T : IComparable
    {
        if (Contains(list1, list2)) return SublistType.Equal;
        if (IsSublist(list1, list2)) return SublistType.Sublist;
        if (IsSublist(list2, list1)) return SublistType.Superlist;
        return SublistType.Unequal;
    }

    private static bool Contains<T>(List<T> left, List<T> right) where T : IComparable
    {
        if (left.Count != right.Count) return false;
        for (var i = 0; i < left.Count; i++)
        {
            if (left[i].CompareTo(right[i]) != 0) return false;
        }

        return true;
    }

    private static bool IsSublist<T>(List<T> shorter, List<T> longer) where T : IComparable
    {
        if (shorter.Count > longer.Count) return false;
        if (shorter.Count == 0) return true;

        for (var start = 0; start <= longer.Count - shorter.Count; start++)
        {
            var matches = true;
            for (var offset = 0; offset < shorter.Count; offset++)
            {
                if (shorter[offset].CompareTo(longer[start + offset]) == 0) continue;
                matches = false;
                break;
            }

            if (matches) return true;
        }

        return false;
    }
}
