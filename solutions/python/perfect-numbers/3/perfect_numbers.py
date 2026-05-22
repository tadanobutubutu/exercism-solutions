def classify(number):
    """ A perfect number equals the sum of its positive divisors.

    :param number: int a positive integer
    :return: str the classification of the input integer
    """
    if number < 1:
        raise ValueError("Classification is only possible for positive integers.")
        
    divisors_sum = sum(i for i in range(1, number) if number % i == 0)
    
    if divisors_sum == number:
        return "perfect"
    if divisors_sum > number:
        return "abundant"
    return "deficient"
