import math

def largest_product(series, size):
    if size == 0:
        return 1
    if size < 0:
        raise ValueError("span must not be negative")
    if len(series) < size:
        raise ValueError("span must not exceed string length")
    if not series.isdigit():
        raise ValueError("digits input must only contain digits")
        
    max_prod = 0
    for i in range(len(series) - size + 1):
        substring = series[i:i+size]
        prod = math.prod(int(d) for d in substring)
        if prod > max_prod:
            max_prod = prod
    return max_prod
