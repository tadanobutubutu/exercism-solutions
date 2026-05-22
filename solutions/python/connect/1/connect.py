from collections import deque


class ConnectGame:
    def __init__(self, board):
        """Initialize the Connect game board."""
        self.board = self._parse_board(board)
        self.rows = len(self.board)
        self.cols = len(self.board[0]) if self.rows > 0 else 0
    
    def _parse_board(self, board_str):
        """Parse the board string into a 2D grid, respecting actual positions."""
        lines = board_str.strip().split('\n')
        grid = []
        for line in lines:
            # We need to maintain the column structure.
            # The input strings are formatted as hex grids.
            # Let's keep the spaces! They indicate column offsets.
            # ". O . ."
            # "  O X X X"
            # If I split by space I lose the alignment.
            # If I keep the spaces, it's easier to see columns.
            
            # Actually, let's just use the grid as is, but remove spaces 
            # while keeping the relative order. No, the spaces shift columns!
            
            # The best way is:
            # Find the first line's non-space position.
            # This is the reference column 0.
            # For each line, the first non-space character is column 0 relative to that line.
            
            row = []
            for c in line:
                if c in ('X', 'O'):
                    row.append(c)
                elif c == '.':
                    row.append('.')
            if row:
                grid.append(row)
        return grid
        
    def _hex_neighbors(self, row, col):
        """Get 6 hex neighbors in a hex grid."""
        # For this grid, the neighbors are:
        # (row, col-1), (row, col+1)
        # (row-1, col), (row-1, col+1)
        # (row+1, col-1), (row+1, col)
        
        # This is correct if the board is:
        # row 0: . O . .
        # row 1: O X X X
        #
        # Let's verify for the example:
        # row 0, col 1 (O)
        # Neighbors: (0,0), (0,2), (-1,1), (-1,2), (1,0), (1,1)
        # These look right! (1,0) is O, (1,1) is X.
        
        neighbors = []
        potential = [
            (row, col - 1), (row, col + 1),
            (row - 1, col), (row - 1, col + 1),
            (row + 1, col - 1), (row + 1, col)
        ]
        for nr, nc in potential:
            if 0 <= nr < self.rows and 0 <= nc < len(self.board[nr]):
                neighbors.append((nr, nc))
        return neighbors
    
    def get_winner(self):
        """Determine the winner of the game."""
        if not self.board or self.rows == 0 or self.cols == 0:
            return ""
        
        if self._check_winner('X'):
            return 'X'
        if self._check_winner('O'):
            return 'O'
        
        return ""
    
    def _check_winner(self, player):
        """Check if a player has won."""
        if player == 'X':
            return self._bfs_x()
        else:
            return self._bfs_o()
    
    def _bfs_x(self):
        """Check if X can connect from left to right."""
        start_nodes = []
        for row in range(self.rows):
            if self.board[row][0] == 'X':
                start_nodes.append((row, 0))
        
        if not start_nodes:
            return False
        
        visited = set(start_nodes)
        queue = deque(start_nodes)
        
        while queue:
            row, col = queue.popleft()
            
            if col == len(self.board[row]) - 1:
                return True
            
            for nr, nc in self._hex_neighbors(row, col):
                if (nr, nc) not in visited and self.board[nr][nc] == 'X':
                    visited.add((nr, nc))
                    queue.append((nr, nc))
        
        return False
    
    def _bfs_o(self):
        """Check if O can connect from top to bottom."""
        start_nodes = []
        for col in range(len(self.board[0])):
            if self.board[0][col] == 'O':
                start_nodes.append((0, col))
        
        if not start_nodes:
            return False
        
        visited = set(start_nodes)
        queue = deque(start_nodes)
        
        while queue:
            row, col = queue.popleft()
            
            if row == self.rows - 1:
                return True
            
            for nr, nc in self._hex_neighbors(row, col):
                if (nr, nc) not in visited and self.board[nr][nc] == 'O':
                    visited.add((nr, nc))
                    queue.append((nr, nc))
        
        return False
