import math

def cipher_text(plain_text):
    cleaned = "".join(c.lower() for c in plain_text if c.isalnum())
    if not cleaned:
        return ""
    
    n = len(cleaned)
    # c * r >= n, c >= r, c - r <= 1
    c = math.ceil(math.sqrt(n))
    r = math.ceil(n / c)
    
    # Pad with spaces
    padded = cleaned.ljust(c * r)
    
    # Divide into rows
    rows = [padded[i:i+c] for i in range(0, len(padded), c)]
    
    # Transpose
    cols = ["".join(row[i] for row in rows) for i in range(c)]
    
    return " ".join(cols)
