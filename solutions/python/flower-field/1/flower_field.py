def annotate(garden):
    if not garden:
        return []
    
    # Validate all rows have same length
    if len(garden) > 0:
        first_len = len(garden[0])
        for row in garden:
            if len(row) != first_len:
                raise ValueError("The board is invalid with current input.")
    
    # Validate all characters are valid
    for row in garden:
        for char in row:
            if char not in ' *':
                raise ValueError("The board is invalid with current input.")
    
    rows = len(garden)
    cols = len(garden[0]) if rows > 0 else 0
    if cols == 0:
        return [""] * rows
        
    result = []
    for r in range(rows):
        row = ""
        for c in range(cols):
            if garden[r][c] == '*':
                row += '*'
            else:
                count = 0
                # Check 8 neighbors
                for dr in [-1, 0, 1]:
                    for dc in [-1, 0, 1]:
                        if dr == 0 and dc == 0:
                            continue
                        nr, nc = r + dr, c + dc
                        if 0 <= nr < rows and 0 <= nc < cols and garden[nr][nc] == '*':
                            count += 1
                row += str(count) if count > 0 else ' '
        result.append(row)
    return result
