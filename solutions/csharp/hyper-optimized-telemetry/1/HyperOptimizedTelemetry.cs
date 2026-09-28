using System.Buffers.Binary;

public static class TelemetryBuffer
{
    public static byte[] ToBuffer(long reading)
    {
        var buffer = new byte[9];
        if (reading < 0)
        {
            if (reading >= short.MinValue)
            {
                buffer[0] = 0xfe;
                BinaryPrimitives.WriteInt16LittleEndian(buffer.AsSpan(1), (short)reading);
            }
            else if (reading >= int.MinValue)
            {
                buffer[0] = 0xfc;
                BinaryPrimitives.WriteInt32LittleEndian(buffer.AsSpan(1), (int)reading);
            }
            else
            {
                buffer[0] = 0xf8;
                BinaryPrimitives.WriteInt64LittleEndian(buffer.AsSpan(1), reading);
            }
        }
        else if (reading <= ushort.MaxValue)
        {
            buffer[0] = 0x02;
            BinaryPrimitives.WriteUInt16LittleEndian(buffer.AsSpan(1), (ushort)reading);
        }
        else if (reading <= int.MaxValue)
        {
            buffer[0] = 0xfc;
            BinaryPrimitives.WriteInt32LittleEndian(buffer.AsSpan(1), (int)reading);
        }
        else if (reading <= uint.MaxValue)
        {
            buffer[0] = 0x04;
            BinaryPrimitives.WriteUInt32LittleEndian(buffer.AsSpan(1), (uint)reading);
        }
        else
        {
            buffer[0] = 0xf8;
            BinaryPrimitives.WriteInt64LittleEndian(buffer.AsSpan(1), reading);
        }
        return buffer;
    }

    public static long FromBuffer(byte[] buffer)
    {
        return buffer.Length switch
        {
            < 9 => 0,
            _ => buffer[0] switch
            {
                0x02 => BinaryPrimitives.ReadUInt16LittleEndian(buffer.AsSpan(1)),
                0xfe => BinaryPrimitives.ReadInt16LittleEndian(buffer.AsSpan(1)),
                0x04 => BinaryPrimitives.ReadUInt32LittleEndian(buffer.AsSpan(1)),
                0xfc => BinaryPrimitives.ReadInt32LittleEndian(buffer.AsSpan(1)),
                0xf8 => BinaryPrimitives.ReadInt64LittleEndian(buffer.AsSpan(1)),
                _ => 0,
            },
        };
    }
}
