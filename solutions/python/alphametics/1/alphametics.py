from itertools import permutations


def solve(puzzle):
    """Solve alphametics puzzle.
    
    Example: "I + BB == ILL"
    Returns: {"I": 1, "B": 9, "L": 0} or None if no solution
    """
    # Parse the puzzle
    parts = puzzle.replace("==", "=").split("=")
    if len(parts) != 2:
        return None
    
    left_side = parts[0].strip()
    right_side = parts[1].strip()
    
    # Parse left side (can be multiple additions)
    addends = [term.strip() for term in left_side.split("+")]
    result = right_side.strip()
    
    # Get all unique letters
    all_letters = set()
    for term in addends + [result]:
        all_letters.update(term)
    
    letters = list(all_letters)
    n = len(letters)
    
    # Get leading letters (cannot be 0)
    leading_letters = set()
    for term in addends + [result]:
        if len(term) > 1:
            leading_letters.add(term[0])
    
    # Try all permutations of digits
    for perm in permutations(range(10), n):
        mapping = dict(zip(letters, perm))
        
        # Check constraint: leading digits cannot be 0
        valid = True
        for letter in leading_letters:
            if mapping[letter] == 0:
                valid = False
                break
        
        if not valid:
            continue
        
        # Convert words to numbers using mapping
        def word_to_number(word):
            num = 0
            for char in word:
                num = num * 10 + mapping[char]
            return num
        
        # Check if the equation is satisfied
        left_sum = sum(word_to_number(term) for term in addends)
        right_sum = word_to_number(result)
        
        if left_sum == right_sum:
            return mapping
    
    return None
