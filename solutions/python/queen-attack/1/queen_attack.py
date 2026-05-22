class Queen:
    def __init__(self, row, col):
        if row < 0:
            raise ValueError("row not positive")
        if row > 7:
            raise ValueError("row not on board")
        if col < 0:
            raise ValueError("column not positive")
        if col > 7:
            raise ValueError("column not on board")
        self.row = row
        self.col = col

    def can_attack(self, other):
        if self.row == other.row and self.col == other.col:
            raise ValueError(
                "Invalid queen position: both queens in the same square"
            )
        return (
            self.row == other.row
            or self.col == other.col
            or abs(self.row - other.row) == abs(self.col - other.col)
        )
