import string

def rows(letter):
    alphabet = string.ascii_uppercase
    n = alphabet.index(letter)
    res = []
    
    # Outer loop for rows
    for i in range(n + 1):
        char = alphabet[i]
        # Spaces outside the letters
        outer_spaces = " " * (n - i)
        if i == 0:
            row = f"{outer_spaces}{char}{outer_spaces}"
        else:
            # Spaces inside the letters
            inner_spaces = " " * (2 * i - 1)
            row = f"{outer_spaces}{char}{inner_spaces}{char}{outer_spaces}"
        res.append(row)
        
    # Append the mirrored bottom part
    return res + res[:-1][::-1]
