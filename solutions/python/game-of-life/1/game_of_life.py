def tick(matrix):
    if not matrix:
        return []
    rows, cols = len(matrix), len(matrix[0])
    result = [[0] * cols for _ in range(rows)]
    for r in range(rows):
        for c in range(cols):
            neighbors = sum(
                matrix[r + dr][c + dc]
                for dr in (-1, 0, 1)
                for dc in (-1, 0, 1)
                if not (dr == 0 and dc == 0)
                and 0 <= r + dr < rows
                and 0 <= c + dc < cols
            )
            if matrix[r][c]:
                result[r][c] = 1 if neighbors in (2, 3) else 0
            else:
                result[r][c] = 1 if neighbors == 3 else 0
    return result
