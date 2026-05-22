def rectangles(strings):
    if not strings:
        return 0
    rows, cols = len(strings), len(strings[0])
    corners = [(r, c) for r in range(rows) for c in range(cols) if strings[r][c] == '+']
    count = 0
    for i, (r1, c1) in enumerate(corners):
        for r2, c2 in corners[i+1:]:
            if r2 > r1 and c2 > c1:
                if all(strings[r1][c] in '-+' for c in range(c1, c2+1)) and \
                   all(strings[r2][c] in '-+' for c in range(c1, c2+1)) and \
                   all(strings[r][c1] in '|+' for r in range(r1, r2+1)) and \
                   all(strings[r][c2] in '|+' for r in range(r1, r2+1)):
                    count += 1
    return count
