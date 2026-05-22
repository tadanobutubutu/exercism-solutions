def gamestate(board):
    """
    Determine the state of a Tic-Tac-Toe game.
    
    Args:
        board: List of 3 strings, each 3 chars long ('X', 'O', or ' ')
    
    Returns:
        'win', 'draw', 'ongoing', or raises ValueError for invalid boards
    """
    # Count X and O
    x_count = sum(row.count('X') for row in board)
    o_count = sum(row.count('O') for row in board)
    
    # Validate turn order
    if x_count < o_count:
        raise ValueError("Wrong turn order: O started")
    if x_count > o_count + 1:
        raise ValueError("Wrong turn order: X went twice")
    
    # Check for win
    x_won = _has_won(board, 'X')
    o_won = _has_won(board, 'O')
    
    # Validate win states
    if x_won and o_won:
        raise ValueError("Impossible board: game should have ended after the game was won")
    
    # If someone won, validate that game ended properly
    if x_won:
        # X won, so O shouldn't have made an extra move
        if x_count != o_count + 1:
            raise ValueError("Impossible board: game should have ended after the game was won")
        return 'win'
    
    if o_won:
        # O won, so moves should be equal
        if x_count != o_count:
            raise ValueError("Impossible board: game should have ended after the game was won")
        return 'win'
    
    # No one won - check if board is full (draw) or has empty spaces (ongoing)
    if x_count + o_count == 9:
        return 'draw'
    else:
        return 'ongoing'


def _has_won(board, player):
    """Check if the player has won."""
    # Check rows
    for row in board:
        if row == player * 3:
            return True
    
    # Check columns
    for col in range(3):
        if board[0][col] == board[1][col] == board[2][col] == player:
            return True
    
    # Check diagonals
    if board[0][0] == board[1][1] == board[2][2] == player:
        return True
    if board[0][2] == board[1][1] == board[2][0] == player:
        return True
    
    return False
