public static class Dominoes
{
    public static bool CanChain(IEnumerable<(int, int)> dominoes)
    {
        var pieces = dominoes.ToArray();
        if (pieces.Length == 0) return true;

        var graph = new Dictionary<int, List<int>>();
        foreach (var (left, right) in pieces)
        {
            if (!graph.TryGetValue(left, out var leftNeighbors)) graph[left] = leftNeighbors = [];
            if (!graph.TryGetValue(right, out var rightNeighbors)) graph[right] = rightNeighbors = [];
            leftNeighbors.Add(right);
            rightNeighbors.Add(left);
        }

        if (graph.Values.Any(neighbors => neighbors.Count % 2 != 0)) return false;

        var start = graph.Keys.First();
        var visited = new HashSet<int> { start };
        var pending = new Stack<int>();
        pending.Push(start);
        while (pending.Count > 0)
        {
            foreach (var neighbor in graph[pending.Pop()])
            {
                if (visited.Add(neighbor)) pending.Push(neighbor);
            }
        }

        return visited.Count == graph.Count;
    }
}
