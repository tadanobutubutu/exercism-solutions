import string

ALPHABET = string.ascii_lowercase
REVERSED = ALPHABET[::-1]
MAP_ENCODE = str.maketrans(ALPHABET, REVERSED)

def encode(plain_text):
    cleaned = "".join(c.lower() for c in plain_text if c.isalnum())
    ciphered = cleaned.translate(MAP_ENCODE)
    return " ".join(ciphered[i:i+5] for i in range(0, len(ciphered), 5))


def decode(ciphered_text):
    cleaned = ciphered_text.replace(" ", "")
    return cleaned.translate(MAP_ENCODE)
