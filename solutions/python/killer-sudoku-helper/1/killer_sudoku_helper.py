from itertools import combinations as iter_combinations


def combinations(target, size, exclude):
    """Find all valid combinations for a killer sudoku cage.
    
    Args:
        target: The sum that digits must add up to
        size: The number of digits in the combination
        exclude: List of digits that cannot be used
    
    Returns:
        List of combinations, sorted, where each combination is a sorted list of digits
    """
    # Available digits are 1-9 minus the excluded ones
    available = [d for d in range(1, 10) if d not in exclude]
    
    # Find all combinations of the given size from available digits
    result = []
    for combo in iter_combinations(available, size):
        if sum(combo) == target:
            result.append(list(combo))
    
    # Result is already sorted since we iterate through combinations in order
    return result
