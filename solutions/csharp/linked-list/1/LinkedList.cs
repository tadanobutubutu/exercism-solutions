public class Deque<T>
{
    private readonly LinkedList<T> values = new();

    public void Push(T value) => values.AddLast(value);

    public T Pop()
    {
        if (values.Last is null)
        {
            throw new InvalidOperationException("Cannot remove an element from an empty deque.");
        }
        T value = values.Last.Value;
        values.RemoveLast();
        return value;
    }

    public void Unshift(T value) => values.AddFirst(value);

    public T Shift()
    {
        if (values.First is null)
        {
            throw new InvalidOperationException("Cannot remove an element from an empty deque.");
        }
        T value = values.First.Value;
        values.RemoveFirst();
        return value;
    }
}
