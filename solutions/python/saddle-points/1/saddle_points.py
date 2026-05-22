def saddle_points(matrix):
    if not matrix:
        return []
    rows = len(matrix)
    cols = len(matrix[0])
    if any(len(row) != cols for row in matrix):
        raise ValueError("irregular matrix")
    row_max = [max(row) for row in matrix]
    col_min = [min(matrix[r][c] for r in range(rows)) for c in range(cols)]
    return [{"row": r + 1, "column": c + 1}
            for r in range(rows) for c in range(cols)
            if matrix[r][c] == row_max[r] == col_min[c]]
