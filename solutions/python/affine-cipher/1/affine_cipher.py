import math
import re


def encode(plain_text, a, b):
    if math.gcd(a, 26) != 1:
        raise ValueError("a and m must be coprime.")
    text = re.sub(r'[^a-z0-9]', '', plain_text.lower())
    result = []
    for c in text:
        if c.isdigit():
            result.append(c)
        else:
            result.append(chr((a * (ord(c) - 97) + b) % 26 + 97))
    encoded = ''.join(result)
    return ' '.join(encoded[i:i+5] for i in range(0, len(encoded), 5))


def decode(ciphertext, a, b):
    if math.gcd(a, 26) != 1:
        raise ValueError("a and m must be coprime.")
    a_inv = pow(a, -1, 26)
    text = re.sub(r'[^a-z0-9]', '', ciphertext.lower())
    result = []
    for c in text:
        if c.isdigit():
            result.append(c)
        else:
            result.append(chr((a_inv * ((ord(c) - 97) - b)) % 26 + 97))
    return ''.join(result)
