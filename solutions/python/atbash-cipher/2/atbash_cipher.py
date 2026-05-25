def encode(plain_text: str) -> str:
    # Create a mapping of each letter to its corresponding cipher letter
    cipher_map = {chr(i): chr(122 - (i - 97)) for i in range(97, 123)}
    
    # Process each character in the plain text
    cipher_text = []
    for char in plain_text.lower():
        if char.isalpha():
            cipher_text.append(cipher_map[char])
        elif char.isdigit():
            cipher_text.append(char)
    
    # Group the cipher text into chunks of 5 characters
    grouped_cipher_text = ' '.join(
        ''.join(cipher_text[i:i+5]) for i in range(0, len(cipher_text), 5)
    )
    
    return grouped_cipher_text
def decode(ciphered_text: str) -> str:
    # Create a mapping of each cipher letter to its corresponding plain letter
    plain_map = {chr(i): chr(122 - (i - 97)) for i in range(97, 123)}
    
    # Process each character in the ciphered text
    plain_text = []
    for char in ciphered_text.lower().replace(' ', ''):
        if char.isalpha():
            plain_text.append(plain_map[char])
        elif char.isdigit():
            plain_text.append(char)
    
    return ''.join(plain_text)