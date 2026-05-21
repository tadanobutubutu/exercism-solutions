class Point:
    def __init__(self, x, y):
        self.x = x
        self.y = y

    def __eq__(self, other):
        return self.x == other.x and self.y == other.y


class WordSearch:
    def __init__(self, puzzle):
        self.grid = [list(row) for row in puzzle]
        self.rows = len(self.grid)
        self.cols = len(self.grid[0]) if self.rows > 0 else 0

    def search(self, word):
        if not word:
            return None
            
        # 8 directions: right, left, down, up, down-right, down-left, up-right, up-left
        directions = [
            (0, 1),   # right
            (0, -1),  # left
            (1, 0),   # down
            (-1, 0),  # up
            (1, 1),   # down-right
            (1, -1),  # down-left
            (-1, 1),  # up-right
            (-1, -1)  # up-left
        ]
        
        for r in range(self.rows):
            for c in range(self.cols):
                for dr, dc in directions:
                    if self._check_word(word, r, c, dr, dc):
                        end_r = r + dr * (len(word) - 1)
                        end_c = c + dc * (len(word) - 1)
                        return (Point(c, r), Point(end_c, end_r))
        return None
        
    def _check_word(self, word, start_r, start_c, dr, dc):
        for i, char in enumerate(word):
            r = start_r + i * dr
            c = start_c + i * dc
            # Check bounds
            if r < 0 or r >= self.rows or c < 0 or c >= self.cols:
                return False
            # Check character match
            if self.grid[r][c] != char:
                return False
        return True
