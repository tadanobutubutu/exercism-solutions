def rebase(input_base: int, digits: list[int], output_base: int) -> list[int]:
    # Check for invalid input and output bases
    if input_base < 2:
        raise ValueError("input base must be >= 2")
    if output_base < 2:
        raise ValueError("output base must be >= 2")
    
    # Check for invalid digits
    for digit in digits:
        if digit < 0 or digit >= input_base:
            raise ValueError("all digits must satisfy 0 <= d < input base")
    
    # Convert the input number to base 10
    base_10_number = 0
    for digit in digits:
        base_10_number = base_10_number * input_base + digit
    
    # Handle the case where the input number is 0
    if base_10_number == 0:
        return [0]
    
    # Convert the base 10 number to the output base
    output_digits = []
    while base_10_number > 0:
        output_digits.append(base_10_number % output_base)
        base_10_number = base_10_number // output_base
    
    # Reverse the list to get the correct order
    output_digits.reverse()
    
    return output_digits