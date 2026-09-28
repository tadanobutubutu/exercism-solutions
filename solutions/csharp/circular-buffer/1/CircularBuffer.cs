public class CircularBuffer<T>
{
    private readonly T[] items;
    private int head;
    private int count;

    public CircularBuffer(int capacity)
    {
        if (capacity <= 0)
        {
            throw new ArgumentOutOfRangeException(nameof(capacity));
        }

        items = new T[capacity];
    }

    public T Read()
    {
        if (count == 0)
        {
            throw new InvalidOperationException("The buffer is empty.");
        }

        var value = items[head];
        items[head] = default!;
        head = (head + 1) % items.Length;
        count--;
        return value;
    }

    public void Write(T value)
    {
        if (count == items.Length)
        {
            throw new InvalidOperationException("The buffer is full.");
        }

        items[(head + count) % items.Length] = value;
        count++;
    }

    public void Overwrite(T value)
    {
        if (count < items.Length)
        {
            Write(value);
            return;
        }

        items[head] = value;
        head = (head + 1) % items.Length;
    }

    public void Clear()
    {
        Array.Clear(items);
        head = 0;
        count = 0;
    }
}
