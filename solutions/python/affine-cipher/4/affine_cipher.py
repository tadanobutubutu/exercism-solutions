import math

def encode(plaintext: str, a: int, b: int) -> str:
    # Check if a and m are coprime
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    # Filter out non-alphanumeric characters and convert to lowercase
    filtered_text = ''.join(c.lower() for c in plaintext if c.isalnum())
    
    # Encrypt each character
    ciphertext = []
    for char in filtered_text:
        if char.isdigit():
            ciphertext.append(char)
        else:
            x = ord(char) - ord('a')
            y = (a * x + b) % m
            ciphertext.append(chr(y + ord('a')))
    
    # Group into 5-letter chunks
    grouped_ciphertext = ' '.join(
        ''.join(ciphertext[i:i+5]) for i in range(0, len(ciphertext), 5)
    )
    
    return grouped_ciphertext
def decode(ciphertext: str, a: int, b: int) -> str:
    # Check if a and m are coprime
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    # Filter out non-alphanumeric characters and convert to lowercase
    filtered_text = ''.join(c.lower() for c in ciphertext if c.isalnum())
    
    # Find modular multiplicative inverse of a
    a_inv = pow(a, -1, m)
    
    # Decrypt each character
    plaintext = []
    for char in filtered_text:
        if char.isdigit():
            plaintext.append(char)
        else:
            y = ord(char) - ord('a')
            x = (a_inv * (y - b)) % m
            plaintext.append(chr(x + ord('a')))
    
    return ''.join(plaintext)