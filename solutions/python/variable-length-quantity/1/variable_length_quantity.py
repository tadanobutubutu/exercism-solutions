def encode(numbers):
    result = []
    for n in numbers:
        chunks = []
        chunks.append(n & 0x7F)
        n >>= 7
        while n:
            chunks.append((n & 0x7F) | 0x80)
            n >>= 7
        result.extend(reversed(chunks))
    return result


def decode(bytes_):
    if not bytes_:
        return []
    # Check if last byte has continuation bit set - that's an incomplete sequence
    if bytes_[-1] & 0x80:
        raise ValueError("incomplete sequence")
    result = []
    value = 0
    for b in bytes_:
        value = (value << 7) | (b & 0x7F)
        if not (b & 0x80):
            result.append(value)
            value = 0
    return result
