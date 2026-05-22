def spiral_matrix(size):
    matrix = [[0] * size for _ in range(size)]
    r, c, dr, dc = 0, 0, 0, 1
    for i in range(1, size * size + 1):
        matrix[r][c] = i
        if matrix[(r + dr) % size][(c + dc) % size]:
            dr, dc = dc, -dr
        r, c = r + dr, c + dc
    return matrix
