def is_palindrome(n):
    """Check if a number is a palindrome."""
    s = str(n)
    return s == s[::-1]


def smallest(min_factor, max_factor):
    """Find the smallest palindromic product of factors in the given range."""
    if min_factor > max_factor:
        raise ValueError("min must be <= max")
    
    palindromes = {}  # value -> set of factor pairs
    
    for i in range(min_factor, max_factor + 1):
        for j in range(i, max_factor + 1):
            product = i * j
            if is_palindrome(product):
                if product not in palindromes:
                    palindromes[product] = set()
                palindromes[product].add(tuple(sorted([i, j])))
    
    if not palindromes:
        return None, []
    
    min_val = min(palindromes.keys())
    factors = sorted(list(palindromes[min_val]))
    return min_val, factors


def largest(min_factor, max_factor):
    """Find the largest palindromic product of factors in the given range."""
    if min_factor > max_factor:
        raise ValueError("min must be <= max")
    
    palindromes = {}  # value -> set of factor pairs
    
    for i in range(min_factor, max_factor + 1):
        for j in range(i, max_factor + 1):
            product = i * j
            if is_palindrome(product):
                if product not in palindromes:
                    palindromes[product] = set()
                palindromes[product].add(tuple(sorted([i, j])))
    
    if not palindromes:
        return None, []
    
    max_val = max(palindromes.keys())
    factors = sorted(list(palindromes[max_val]))
    return max_val, factors
