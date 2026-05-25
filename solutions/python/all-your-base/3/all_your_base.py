def rebase(input_base: int, digits: list[int], output_base: int) -> list[int]:
    # Check if input base is valid
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    
    # Check if output base is valid
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    # Check if all digits are valid
    for digit in digits:
        if digit < 0 or digit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
    
    # Convert the number to base 10
    number = 0
    for digit in digits:
        number = number * input_base + digit
    
    # Handle the case where the number is 0
    if number == 0:
        return [0]
    
    # Convert the number to the output base
    result = []
    while number > 0:
        result.append(number % output_base)
        number = number // output_base
    
    # Reverse the result to get the correct order
    result.reverse()
    
    return result