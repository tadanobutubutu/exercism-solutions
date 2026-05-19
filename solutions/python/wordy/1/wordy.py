import re

def answer(question):
    # Initial validation
    if not question.startswith("What is") or not question.endswith("?"):
        raise ValueError("unknown operation")
        
    text = question[7:-1].strip()
    if not text:
        raise ValueError("syntax error")
        
    # Standardize operations
    text = text.replace("multiplied by", "multiplied")
    text = text.replace("divided by", "divided")
    
    tokens = text.split()
    
    # 1. First, validate tokens for unknown words
    for token in tokens:
        try:
            int(token)
        except ValueError:
            if token not in ('plus', 'minus', 'multiplied', 'divided'):
                raise ValueError("unknown operation")

    # 2. Then, validate sequence for syntax errors
    for i, token in enumerate(tokens):
        is_even = (i % 2 == 0)
        try:
            int(token)
            if not is_even:
                # Number where OP should be
                raise ValueError("syntax error")
        except ValueError:
            # Must be an OP (already validated it's one of the 4)
            if is_even:
                # OP where NUMBER should be
                raise ValueError("syntax error")
                
    # 3. If it ends with an OP, it's a syntax error
    if len(tokens) % 2 == 0:
        raise ValueError("syntax error")
        
    # 4. Calculation
    res = int(tokens[0])
    for i in range(1, len(tokens), 2):
        op = tokens[i]
        val = int(tokens[i+1])
        
        if op == 'plus': res += val
        elif op == 'minus': res -= val
        elif op == 'multiplied': res *= val
        elif op == 'divided': res //= val
        
    return res
