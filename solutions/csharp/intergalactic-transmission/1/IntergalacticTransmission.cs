public static class IntergalacticTransmission
{
    public static byte[] GetTransmitSequence(byte[] message)
    {
        ArgumentNullException.ThrowIfNull(message);
        var bits = new List<int>(message.Length * 8);
        foreach (byte value in message)
        {
            for (int bit = 7; bit >= 0; bit--)
            {
                bits.Add((value >> bit) & 1);
            }
        }

        var sequence = new byte[(bits.Count + 6) / 7];
        for (int chunk = 0; chunk < sequence.Length; chunk++)
        {
            int transmitted = 0;
            int ones = 0;
            for (int offset = 0; offset < 7; offset++)
            {
                int bitIndex = chunk * 7 + offset;
                int bit = bitIndex < bits.Count ? bits[bitIndex] : 0;
                transmitted = (transmitted << 1) | bit;
                ones += bit;
            }

            int parity = ones % 2;
            sequence[chunk] = (byte)((transmitted << 1) | parity);
        }

        return sequence;
    }

    public static byte[] DecodeSequence(byte[] receivedSeq)
    {
        ArgumentNullException.ThrowIfNull(receivedSeq);
        var dataBits = new List<int>(receivedSeq.Length * 7);
        foreach (byte transmitted in receivedSeq)
        {
            if (CountOnes(transmitted) % 2 != 0)
            {
                throw new ArgumentException("A received byte has invalid even parity.", nameof(receivedSeq));
            }

            for (int bit = 7; bit >= 1; bit--)
            {
                dataBits.Add((transmitted >> bit) & 1);
            }
        }

        int messageByteCount = receivedSeq.Length * 7 / 8;
        int messageBitCount = messageByteCount * 8;
        var message = new byte[messageByteCount];
        for (int bitIndex = 0; bitIndex < messageBitCount; bitIndex++)
        {
            message[bitIndex / 8] = (byte)((message[bitIndex / 8] << 1) | dataBits[bitIndex]);
        }

        return message;
    }

    private static int CountOnes(byte value)
    {
        int count = 0;
        while (value != 0)
        {
            count += value & 1;
            value >>= 1;
        }
        return count;
    }
}
