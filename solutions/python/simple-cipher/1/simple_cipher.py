import string
import re

class Cipher:
    def __init__(self, key=None):
        if key is None:
            import random
            key = ''.join(random.choice(string.ascii_lowercase) for _ in range(100))
        if not key or not re.match(r'^[a-z]+$', key):
            raise ValueError("Invalid key")
        self.key = key

    def encode(self, text):
        return ''.join(
            chr((ord(c) - 97 + ord(self.key[i % len(self.key)]) - 97) % 26 + 97)
            for i, c in enumerate(text)
        )

    def decode(self, text):
        return ''.join(
            chr((ord(c) - 97 - (ord(self.key[i % len(self.key)]) - 97)) % 26 + 97)
            for i, c in enumerate(text)
        )
