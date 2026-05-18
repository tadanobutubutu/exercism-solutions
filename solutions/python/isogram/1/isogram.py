def is_isogram(string):
    cleaned = [c.lower() for c in string if c.isalpha()]
    return len(cleaned) == len(set(cleaned))
