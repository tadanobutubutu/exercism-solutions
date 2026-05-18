DIGITS = {
    " _ | ||_|   ": "0",
    "     |  |   ": "1",
    " _  _||_    ": "2",
    " _  _| _|   ": "3",
    "   |_|  |   ": "4",
    " _ |_  _|   ": "5",
    " _ |_ |_|   ": "6",
    " _   |  |   ": "7",
    " _ |_||_|   ": "8",
    " _ |_| _|   ": "9"
}

def convert(input_grid):
    if len(input_grid) % 4 != 0:
        raise ValueError("Number of input lines is not a multiple of four")
    if any(len(line) % 3 != 0 for line in input_grid):
        raise ValueError("Number of input columns is not a multiple of three")
        
    res = []
    for r in range(0, len(input_grid), 4):
        group_res = ""
        for c in range(0, len(input_grid[r]), 3):
            pattern = ""
            for dr in range(4):
                pattern += input_grid[r+dr][c:c+3]
            group_res += DIGITS.get(pattern, "?")
        res.append(group_res)
        
    return ",".join(res)
