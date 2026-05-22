def encode(plaintext, num_rails):
    if num_rails == 1:
        return plaintext
    rails = [''] * num_rails
    rail = 0
    step = 1
    for char in plaintext:
        rails[rail] += char
        rail += step
        if rail == 0:
            step = 1
        elif rail == num_rails - 1:
            step = -1
    return ''.join(rails)


def decode(ciphertext, num_rails):
    if num_rails == 1:
        return ciphertext
        
    # Calculate rail lengths
    rail_lengths = [0] * num_rails
    rail = 0
    step = 1
    for _ in ciphertext:
        rail_lengths[rail] += 1
        rail += step
        if rail == 0:
            step = 1
        elif rail == num_rails - 1:
            step = -1
    
    # Split ciphertext into rails
    rails = []
    start = 0
    for length in rail_lengths:
        rails.append(ciphertext[start:start+length])
        start += length
    
    # Read characters from rails in zigzag order
    result = []
    rail = 0
    step = 1
    pointers = [0] * num_rails
    for _ in ciphertext:
        result.append(rails[rail][pointers[rail]])
        pointers[rail] += 1
        rail += step
        if rail == 0:
            step = 1
        elif rail == num_rails - 1:
            step = -1
            
    return ''.join(result)
