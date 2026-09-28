public class RelativeDistance
{
    private readonly Dictionary<string, HashSet<string>> connections = new(StringComparer.Ordinal);

    public RelativeDistance(Dictionary<string, string[]> familyTree)
    {
        ArgumentNullException.ThrowIfNull(familyTree);

        void AddConnection(string person, string relative)
        {
            if (!connections.ContainsKey(person)) connections[person] = new HashSet<string>(StringComparer.Ordinal);
            if (!connections.ContainsKey(relative)) connections[relative] = new HashSet<string>(StringComparer.Ordinal);
            connections[person].Add(relative);
            connections[relative].Add(person);
        }

        foreach (var (parent, children) in familyTree)
        {
            ArgumentNullException.ThrowIfNull(children);
            foreach (string child in children)
            {
                AddConnection(parent, child);
            }

            for (int first = 0; first < children.Length; first++)
            {
                for (int second = first + 1; second < children.Length; second++)
                {
                    AddConnection(children[first], children[second]);
                }
            }
        }
    }
    
    public int DegreeOfSeparation(string personA, string personB)
    {
        if (personA == personB && connections.ContainsKey(personA)) return 0;
        if (!connections.ContainsKey(personA) || !connections.ContainsKey(personB)) return -1;

        var distances = new Dictionary<string, int>(StringComparer.Ordinal) { [personA] = 0 };
        var pending = new Queue<string>();
        pending.Enqueue(personA);
        while (pending.Count > 0)
        {
            string current = pending.Dequeue();
            int distance = distances[current];
            foreach (string relative in connections[current])
            {
                if (distances.ContainsKey(relative)) continue;
                int nextDistance = distance + 1;
                if (relative == personB) return nextDistance;
                distances[relative] = nextDistance;
                pending.Enqueue(relative);
            }
        }

        return -1;
    }
}
