from itertools import permutations

def solve(puzzle: str) -> dict[str, int]:
    # Parse the puzzle into left and right parts
    left, right = puzzle.split(' == ')
    
    # Extract all unique letters from the puzzle
    letters = set(c for c in left + right if c.isalpha())
    
    # Generate all possible digit assignments
    for digits in permutations(range(10), len(letters)):
        # Create a mapping of letters to digits
        mapping = dict(zip(letters, digits))
        
        # Check if any leading digit is zero
        if any(mapping[c] == 0 and (c == left[0] or c == right[0]) for c in letters):
            continue
        
        # Convert the left and right parts to numbers using the mapping
        left_num = int(''.join(str(mapping[c]) for c in left if c.isalpha()))
        right_num = int(''.join(str(mapping[c]) for c in right if c.isalpha()))
        
        # Check if the sum of the left parts equals the right part
        if left_num + right_num == int(''.join(str(mapping[c]) for c in right if c.isalpha())):
            return mapping
    
    return None