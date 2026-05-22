def rows(letter):
    if letter == 'A':
        return ['A']
    
    alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    index = alphabet.index(letter)
    width = 2 * index + 1
    
    result = []
    
    # Upper half + middle
    for i in range(index + 1):
        char = alphabet[i]
        if i == 0:
            row = ' ' * index + char + ' ' * index
        else:
            outer_spaces = ' ' * (index - i)
            inner_spaces = ' ' * (2 * i - 1)
            row = outer_spaces + char + inner_spaces + char + outer_spaces
        result.append(row)
        
    # Lower half
    for i in range(index - 1, -1, -1):
        result.append(result[i])
        
    return result
