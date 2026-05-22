def distance(one, other):
    if len(one) != len(other):
        raise ValueError("Strands must be of equal length.")
    return sum(a != b for a, b in zip(one, other))
