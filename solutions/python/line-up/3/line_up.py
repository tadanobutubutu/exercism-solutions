def line_up(name, number):
    # 下2桁が11, 12, 13の場合は 'th'
    if 11 <= (number % 100) <= 13:
        suffix = 'th'
    else:
        # 下1桁が1なら 'st', 2なら 'nd', 3なら 'rd', その他は 'th'
        last_digit = number % 10
        if last_digit == 1:
            suffix = 'st'
        elif last_digit == 2:
            suffix = 'nd'
        elif last_digit == 3:
            suffix = 'rd'
        else:
            suffix = 'th'
            
    return f"{name}, you are the {number}{suffix} customer we serve today. Thank you!"
