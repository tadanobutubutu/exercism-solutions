def rebase(input_base: int, digits: list[int], output_base: int) -> list[int]:
    """
    Convert a sequence of digits in one base to another base.
    
    Args:
        input_base: The base of the input digits.
        digits: The sequence of digits to convert.
        output_base: The base to convert the digits to.
    
    Returns:
        list[int]: The sequence of digits in the new base.
    
    Raises:
        ValueError: If input_base or output_base is less than 2, or if any digit is invalid.
    """
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    # Convert the input digits to a number in base 10
    number = 0
    for digit in digits:
        if digit < 0 or digit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
        number = number * input_base + digit
    
    # Handle the case where the input is an empty list or all zeros
    if number == 0:
        return [0]
    
    # Convert the number to the output base
    if output_base == 10:
        return [number]
    
    result = []
    while number > 0:
        result.append(number % output_base)
        number = number // output_base
    
    # Reverse the result to get the correct order
    result.reverse()
    
    return result