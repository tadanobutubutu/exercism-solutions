def is_armstrong_number(number: int) -> bool:
    # Convert the number to a string to iterate over each digit
    digits = str(number)
    # Calculate the sum of each digit raised to the power of the number of digits
    sum_of_powers = sum(int(digit) ** len(digits) for digit in digits)
    # Check if the sum of the powers is equal to the original number
    return sum_of_powers == number