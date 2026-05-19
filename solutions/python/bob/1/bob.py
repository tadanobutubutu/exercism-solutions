def response(hey_bob):
    hey_bob = hey_bob.strip()
    if not hey_bob:
        return "Fine. Be that way!"
    
    is_question = hey_bob.endswith('?')
    is_shelling = hey_bob.isupper()
    
    if is_shelling and is_question:
        return "Calm down, I know what I'm doing!"
    if is_shelling:
        return "Whoa, chill out!"
    if is_question:
        return "Sure."
    
    return "Whatever."
