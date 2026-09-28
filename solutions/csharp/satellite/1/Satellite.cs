public record Tree(char Value, Tree? Left, Tree? Right);

public static class Satellite
{
    public static Tree? TreeFromTraversals(char[] preOrder, char[] inOrder)
    {
        ArgumentNullException.ThrowIfNull(preOrder);
        ArgumentNullException.ThrowIfNull(inOrder);

        if (preOrder.Length != inOrder.Length)
            throw new ArgumentException("The traversals must have the same length.");
        if (preOrder.Length == 0) return null;

        var inOrderPositions = new Dictionary<char, int>();
        foreach (char value in inOrder)
        {
            if (!inOrderPositions.TryAdd(value, inOrderPositions.Count))
                throw new ArgumentException("The traversals cannot contain repeated items.");
        }

        var preOrderValues = new HashSet<char>();
        foreach (char value in preOrder)
        {
            if (!preOrderValues.Add(value))
                throw new ArgumentException("The traversals cannot contain repeated items.");
        }
        if (!preOrderValues.SetEquals(inOrderPositions.Keys))
            throw new ArgumentException("The traversals must contain the same items.");

        int nextRootIndex = 0;
        Tree? Build(int start, int end)
        {
            if (start >= end) return null;
            if (nextRootIndex >= preOrder.Length)
                throw new ArgumentException("The traversals are inconsistent.");

            char rootValue = preOrder[nextRootIndex++];
            int split = inOrderPositions[rootValue];
            if (split < start || split >= end)
                throw new ArgumentException("The traversals are inconsistent.");

            Tree? left = Build(start, split);
            Tree? right = Build(split + 1, end);
            return new Tree(rootValue, left, right);
        }

        Tree? result = Build(0, inOrder.Length);
        if (nextRootIndex != preOrder.Length)
            throw new ArgumentException("The traversals are inconsistent.");
        return result;
    }
}
