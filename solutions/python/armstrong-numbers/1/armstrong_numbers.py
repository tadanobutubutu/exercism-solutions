def is_armstrong_number(number):
    str_num = str(number)
    num_digits = len(str_num)
    total = sum(int(digit) ** num_digits for digit in str_num)
    return total == number
