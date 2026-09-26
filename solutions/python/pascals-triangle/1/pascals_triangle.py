def rows(row_count):
    if row_count < 0:
        raise ValueError("number of rows is negative")
    if row_count == 0:
        return []

    triangle = rows(row_count - 1)
    previous = triangle[-1] if triangle else []
    current = [1] * row_count
    for index in range(1, row_count - 1):
        current[index] = previous[index - 1] + previous[index]
    return triangle + [current]
