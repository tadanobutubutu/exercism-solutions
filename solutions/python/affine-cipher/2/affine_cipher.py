import math

def encode(plain_text: str, a: int, b: int) -> str:
    # Check if a and m are coprime
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    # Process the plain text: remove non-alphanumeric characters and convert to lowercase
    processed_text = ''.join(c.lower() for c in plain_text if c.isalnum())
    
    # Encrypt each character
    encrypted_chars = []
    for char in processed_text:
        if char.isdigit():
            encrypted_chars.append(char)
        else:
            x = ord(char) - ord('a')
            y = (a * x + b) % m
            encrypted_char = chr(y + ord('a'))
            encrypted_chars.append(encrypted_char)
    
    # Group the encrypted text into chunks of 5 characters
    encrypted_text = ' '.join(
        ''.join(encrypted_chars[i:i+5]) for i in range(0, len(encrypted_chars), 5)
    )
    
    return encrypted_text
def decode(ciphered_text: str, a: int, b: int) -> str:
    # Check if a and m are coprime
    m = 26
    if math.gcd(a, m) != 1:
        raise ValueError("a and m must be coprime.")
    
    # Process the ciphered text: remove spaces and convert to lowercase
    processed_text = ''.join(c.lower() for c in ciphered_text if c.isalnum())
    
    # Find the modular multiplicative inverse of a
    a_inv = pow(a, -1, m)
    
    # Decrypt each character
    decrypted_chars = []
    for char in processed_text:
        if char.isdigit():
            decrypted_chars.append(char)
        else:
            y = ord(char) - ord('a')
            x = (a_inv * (y - b)) % m
            decrypted_char = chr(x + ord('a'))
            decrypted_chars.append(decrypted_char)
    
    # Join the decrypted characters into a single string
    decrypted_text = ''.join(decrypted_chars)
    
    return decrypted_text