def is_armstrong_number(number: int) -> bool:
    """
    Check if a number is an Armstrong number.
    
    Args:
        number: The number to check.
    
    Returns:
        bool: True if the number is an Armstrong number, False otherwise.
    """
    digits = [int(d) for d in str(number)]
    num_digits = len(digits)
    armstrong_sum = sum(d ** num_digits for d in digits)
    return armstrong_sum == number