def is_paired(input_string):
    stack = []
    mapping = {')': '(', ']': '[', '}': '{'}
    
    for char in input_string:
        if char in mapping.values():
            stack.append(char)
        elif char in mapping.keys():
            if not stack or stack.pop() != mapping[char]:
                return False
    
    return not stack
