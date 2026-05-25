from itertools import permutations

def solve(puzzle: str) -> dict[str, int]:
    """
    Solve the alphametics puzzle.
    
    Args:
        puzzle: The alphametics puzzle as a string.
    
    Returns:
        dict[str, int]: A dictionary mapping each letter to its corresponding digit.
    """
    # Parse the puzzle into left and right parts
    left, right = puzzle.split('==')
    left_parts = left.split('+')
    right_part = right.strip()
    
    # Extract all unique letters from the puzzle
    letters = set()
    for part in left_parts + [right_part]:
        letters.update(part.strip())
    
    letters = sorted(letters)
    
    # Generate all possible permutations of digits for the letters
    for perm in permutations(range(10), len(letters)):
        # Create a mapping of letters to digits
        mapping = dict(zip(letters, perm))
        
        # Check if any leading digit is zero
        if any(mapping[word[0]] == 0 for word in left_parts + [right_part]):
            continue
        
        # Convert each word to a number using the mapping
        left_sum = sum(int(''.join(str(mapping[char]) for char in word.strip())) for word in left_parts)
        right_sum = int(''.join(str(mapping[char]) for char in right_part.strip()))
        
        # Check if the sum of the left parts equals the right part
        if left_sum == right_sum:
            return mapping
    
    return None