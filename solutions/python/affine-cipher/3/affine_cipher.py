def encode(plain_text: str, a: int, b: int) -> str:
    """
    Encrypts the given plain text using the affine cipher with the provided key.
    
    Args:
        plain_text: The text to encrypt.
        a: The first part of the encryption key.
        b: The second part of the encryption key.
    
    Returns:
        str: The encrypted text.
    
    Raises:
        ValueError: If a and m are not coprime.
    """
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    cipher_text = []
    for char in plain_text.lower():
        if char.isalpha():
            x = ord(char) - ord('a')
            y = (a * x + b) % m
            cipher_text.append(chr(y + ord('a')))
        elif char.isdigit():
            cipher_text.append(char)
    
    # Group the cipher text into chunks of 5 characters
    grouped_cipher = ' '.join([''.join(cipher_text[i:i+5]) for i in range(0, len(cipher_text), 5)])
    return grouped_cipher

def decode(ciphered_text: str, a: int, b: int) -> str:
    """
    Decrypts the given ciphered text using the affine cipher with the provided key.
    
    Args:
        ciphered_text: The text to decrypt.
        a: The first part of the decryption key.
        b: The second part of the decryption key.
    
    Returns:
        str: The decrypted text.
    
    Raises:
        ValueError: If a and m are not coprime.
    """
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    # Find the modular inverse of a
    a_inv = pow(a, -1, m)
    
    plain_text = []
    for char in ciphered_text.lower():
        if char.isalpha():
            y = ord(char) - ord('a')
            x = (a_inv * (y - b)) % m
            plain_text.append(chr(x + ord('a')))
        elif char.isdigit():
            plain_text.append(char)
    
    return ''.join(plain_text)