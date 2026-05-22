def triplets_with_sum(n):
    result = []
    for a in range(1, n // 3):
        num = n * (n - 2 * a)
        den = 2 * (n - a)
        if num % den == 0:
            b = num // den
            c = n - a - b
            if a < b < c:
                result.append([a, b, c])
    return result
