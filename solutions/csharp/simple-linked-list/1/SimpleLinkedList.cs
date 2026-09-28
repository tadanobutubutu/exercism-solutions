using System.Collections;

public class SimpleLinkedList<T> : IEnumerable<T>
{
    private sealed class Node(T value, Node? next)
    {
        public T Value { get; } = value;
        public Node? Next { get; set; } = next;
    }

    private Node? head;
    public int Count { get; private set; }

    public SimpleLinkedList()
    {
    }

    public SimpleLinkedList(T value)
    {
        Push(value);
    }

    public SimpleLinkedList(params T[] values) : this((IEnumerable<T>)values)
    {
    }

    public SimpleLinkedList(IEnumerable<T> values)
    {
        ArgumentNullException.ThrowIfNull(values);
        foreach (T value in values)
        {
            Push(value);
        }
    }
    
    public void Push(T value)
    {
        head = new Node(value, head);
        Count++;
    }

    public T Pop()
    {
        if (head is null)
        {
            throw new InvalidOperationException("Cannot pop from an empty list.");
        }

        T value = head.Value;
        head = head.Next;
        Count--;
        return value;
    }

    public IEnumerator<T> GetEnumerator()
    {
        for (Node? current = head; current is not null; current = current.Next)
        {
            yield return current.Value;
        }
    }

    IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
}
