WHITE = "W"
BLACK = "B"
NONE = ""


class Board:
    """Count territories of each player in a Go game

    Args:
        board (list[str]): A two-dimensional Go board
    """

    def __init__(self, board):
        self.height = len(board)
        self.width = len(board[0]) if board else 0
        self.board = list(board)

    def territory(self, x, y):
        """Find the owner and the territories given a coordinate on
           the board

        Args:
            x (int): Column on the board
            y (int): Row on the board

        Returns:
            (str, set): A tuple, the first element being the owner
                        of that area.  One of "W", "B", "".  The
                        second being a set of coordinates, representing
                        the owner's territories.
        """
        if not (0 <= x < self.width and 0 <= y < self.height):
            raise ValueError("Invalid coordinate")
        if self.board[y][x] != " ":
            return NONE, set()

        pending = [(x, y)]
        region = set()
        bordering = set()
        while pending:
            point = pending.pop()
            if point in region:
                continue
            px, py = point
            if not (0 <= px < self.width and 0 <= py < self.height):
                continue
            cell = self.board[py][px]
            if cell == " ":
                region.add(point)
                pending.extend(
                    ((px + 1, py), (px - 1, py), (px, py + 1), (px, py - 1))
                )
            else:
                bordering.add(cell)

        owner = next(iter(bordering)) if len(bordering) == 1 else NONE
        return owner, region

    def territories(self):
        """Find the owners and the territories of the whole board

        Args:
            none

        Returns:
            dict(str, set): A dictionary whose key being the owner
                        , i.e. "W", "B", "".  The value being a set
                        of coordinates owned by the owner.
        """
        result = {BLACK: set(), WHITE: set(), NONE: set()}
        visited = set()
        for y in range(self.height):
            for x in range(self.width):
                if self.board[y][x] != " " or (x, y) in visited:
                    continue
                owner, region = self.territory(x, y)
                result[owner].update(region)
                visited.update(region)
        return result
