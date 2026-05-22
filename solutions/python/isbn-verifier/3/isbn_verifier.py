def is_valid(isbn):
    cleaned = isbn.replace('-', '')
    if len(cleaned) != 10:
        return False
    
    total = 0
    for i in range(9):
        if not cleaned[i].isdigit():
            return False
        total += int(cleaned[i]) * (10 - i)
    
    last_char = cleaned[9]
    if last_char == 'X':
        total += 10
    elif last_char.isdigit():
        total += int(last_char)
    else:
        return False
        
    return total % 11 == 0
