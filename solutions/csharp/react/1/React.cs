public class Reactor
{
    private readonly List<ComputeCell> _computeCells = [];

    public InputCell CreateInputCell(int value) => new(this, value);

    public ComputeCell CreateComputeCell(IEnumerable<Cell> producers, Func<int[], int> compute)
    {
        ArgumentNullException.ThrowIfNull(producers);
        ArgumentNullException.ThrowIfNull(compute);

        Cell[] sourceCells = producers.ToArray();
        if (sourceCells.Any(cell => cell is null))
            throw new ArgumentException("A producer cannot be null.", nameof(producers));

        var cell = new ComputeCell(sourceCells, compute);
        _computeCells.Add(cell);
        return cell;
    }

    internal void Update(InputCell input, int value)
    {
        if (input.CurrentValue == value) return;
        input.SetValue(value);

        var changedCells = new HashSet<Cell> { input };
        var changedComputes = new List<ComputeCell>();
        foreach (ComputeCell computeCell in _computeCells)
        {
            if (!computeCell.Producers.Any(changedCells.Contains)) continue;
            int updatedValue = computeCell.Calculate();
            if (updatedValue == computeCell.CurrentValue) continue;

            computeCell.SetValue(updatedValue);
            changedCells.Add(computeCell);
            changedComputes.Add(computeCell);
        }

        foreach (ComputeCell computeCell in changedComputes)
            computeCell.RaiseChanged();
    }
}

public abstract class Cell
{
    internal abstract int CurrentValue { get; }
}

public class InputCell : Cell
{
    private readonly Reactor _reactor;
    private int _value;

    internal InputCell(Reactor reactor, int value)
    {
        _reactor = reactor;
        _value = value;
    }

    public int Value
    {
        get => _value;
        set => _reactor.Update(this, value);
    }

    internal override int CurrentValue => _value;
    internal void SetValue(int value) => _value = value;
}

public class ComputeCell : Cell
{
    private readonly Func<int[], int> _compute;

    internal ComputeCell(Cell[] producers, Func<int[], int> compute)
    {
        Producers = producers;
        _compute = compute;
        Value = Calculate();
    }

    internal Cell[] Producers { get; }
    public int Value { get; private set; }
    public event EventHandler<int>? Changed;
    internal override int CurrentValue => Value;
    internal int Calculate() => _compute(Producers.Select(cell => cell.CurrentValue).ToArray());
    internal void SetValue(int value) => Value = value;
    internal void RaiseChanged() => Changed?.Invoke(this, Value);
}
