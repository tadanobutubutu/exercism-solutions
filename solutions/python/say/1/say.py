def say(number):
    if number < 0 or number > 999_999_999_999:
        raise ValueError("input out of range")
    
    if number == 0:
        return "zero"

    ones = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
            "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
    tens = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

    def say_under_100(n):
        if n < 20:
            return ones[n]
        else:
            tens_part = tens[n // 10]
            ones_part = ones[n % 10]
            if ones_part:
                return f"{tens_part}-{ones_part}"
            return tens_part

    def say_under_1000(n):
        hundreds = n // 100
        remainder = n % 100
        parts = []
        if hundreds > 0:
            parts.append(f"{ones[hundreds]} hundred")
        if remainder > 0:
            parts.append(say_under_100(remainder))
        return " ".join(parts)

    temp = number
    groups = []
    while temp > 0:
        groups.append(temp % 1000)
        temp //= 1000

    units = ["", "thousand", "million", "billion"]
    results = []
    for i, g in enumerate(groups):
        if g > 0:
            g_str = say_under_1000(g)
            unit = units[i]
            if unit:
                results.append(f"{g_str} {unit}")
            else:
                results.append(g_str)

    results.reverse()
    return " ".join(results)
