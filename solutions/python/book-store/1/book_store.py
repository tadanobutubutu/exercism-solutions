from collections import Counter
from functools import lru_cache
from itertools import combinations


def total(basket):
    """Calculate the minimum price for a basket of books with discounts.
    
    Price in cents: base price is 800 cents per book
    
    Discounts apply based on number of different books in a group:
    - 1 book: no discount (800 cents)
    - 2 different: 5% off (760 cents each)
    - 3 different: 10% off (720 cents each)
    - 4 different: 20% off (640 cents each)
    - 5 different: 25% off (600 cents each)
    """
    if not basket:
        return 0
    
    # Count occurrences of each book (normalize to 1-5)
    book_counts = [0] * 5
    for book in basket:
        book_counts[book - 1] += 1
    
    # Discount rates for groups of different books
    discounts = {
        1: 0.00,    # 1 book: 800 cents
        2: 0.05,    # 2 books: 760 cents each
        3: 0.10,    # 3 books: 720 cents each
        4: 0.20,    # 4 books: 640 cents each
        5: 0.25,    # 5 books: 600 cents each
    }
    
    book_price_cents = 800
    
    @lru_cache(maxsize=None)
    def min_cost(state):
        """Find minimum cost for a given book distribution.
        
        state: tuple of 5 elements with book counts
        """
        # Base case: no books left
        if all(c == 0 for c in state):
            return 0
        
        best_cost = float('inf')
        
        # Get books that still have inventory
        available_books = [i for i in range(5) if state[i] > 0]
        
        # Try all possible group sizes (1 to 5 different books)
        for group_size in range(1, min(6, len(available_books) + 1)):
            # Try all combinations of group_size books from available
            for books_in_group in combinations(available_books, group_size):
                # Calculate cost of this group in cents
                group_cost = group_size * book_price_cents * (1 - discounts[group_size])
                
                # Create new state with these books removed
                new_state = list(state)
                for book_idx in books_in_group:
                    new_state[book_idx] -= 1
                new_state = tuple(new_state)
                
                # Recursively solve for remaining books
                total_cost = group_cost + min_cost(new_state)
                best_cost = min(best_cost, total_cost)
        
        return best_cost
    
    # Create initial state tuple
    initial_state = tuple(book_counts)
    return int(round(min_cost(initial_state)))
