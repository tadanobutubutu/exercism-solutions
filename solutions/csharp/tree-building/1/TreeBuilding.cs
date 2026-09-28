public class TreeBuildingRecord
{
    public int ParentId { get; set; }
    public int RecordId { get; set; }
}

public class Tree
{
    public int Id { get; set; }
    public int ParentId { get; set; }

    public List<Tree> Children { get; set; } = [];

    public bool IsLeaf => Children.Count == 0;
}

public static class TreeBuilder
{
    public static Tree BuildTree(IEnumerable<TreeBuildingRecord> records)
    {
        var ordered = records.OrderBy(record => record.RecordId).ToArray();
        if (ordered.Length == 0) throw new ArgumentException("The tree must have a root.", nameof(records));

        var nodes = new Dictionary<int, Tree>();
        for (var i = 0; i < ordered.Length; i++)
        {
            var record = ordered[i];
            if (record.RecordId != i || nodes.ContainsKey(record.RecordId))
            {
                throw new ArgumentException("Record IDs must be unique and contiguous from zero.", nameof(records));
            }

            if ((record.RecordId == 0 && record.ParentId != 0) || (record.RecordId > 0 && (record.ParentId < 0 || record.ParentId >= record.RecordId)))
            {
                throw new ArgumentException("Records must form a tree rooted at zero.", nameof(records));
            }

            nodes.Add(record.RecordId, new Tree { Id = record.RecordId, ParentId = record.ParentId });
        }

        if (!nodes.ContainsKey(0)) throw new ArgumentException("The tree must have a root.", nameof(records));
        for (var id = 1; id < ordered.Length; id++)
        {
            nodes[ordered[id].ParentId].Children.Add(nodes[id]);
        }

        return nodes[0];
    }
}
