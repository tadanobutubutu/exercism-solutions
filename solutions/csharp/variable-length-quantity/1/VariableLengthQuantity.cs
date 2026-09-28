public static class VariableLengthQuantity
{
    public static uint[] Encode(uint[] numbers)
    {
        var encoded = new List<uint>();
        foreach (var number in numbers)
        {
            var chunks = new List<uint>();
            var remaining = number;
            do
            {
                chunks.Add(remaining & 0x7F);
                remaining >>= 7;
            } while (remaining != 0);

            for (var i = chunks.Count - 1; i >= 0; i--)
            {
                var chunk = chunks[i];
                encoded.Add(i > 0 ? chunk | 0x80 : chunk);
            }
        }

        return encoded.ToArray();
    }

    public static uint[] Decode(uint[] bytes)
    {
        var decoded = new List<uint>();
        uint value = 0;
        var pending = false;

        foreach (var current in bytes)
        {
            if (current > byte.MaxValue)
            {
                throw new ArgumentOutOfRangeException(nameof(bytes));
            }

            value = (value << 7) | (current & 0x7F);
            pending = (current & 0x80) != 0;
            if (!pending)
            {
                decoded.Add(value);
                value = 0;
            }
        }

        if (pending)
        {
            throw new InvalidOperationException("Incomplete variable-length quantity.");
        }

        return decoded.ToArray();
    }
}
