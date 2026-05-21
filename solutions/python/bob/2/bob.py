def response(hey_bob):
    hey_bob = hey_bob.strip()
    if not hey_bob:
        return "Fine. Be that way!"
    is_question = hey_bob.endswith("?")
    is_shouting = hey_bob.isupper() and any(c.isalpha() for c in hey_bob)
    if is_shouting and is_question:
        return "Calm down, I know what I'm doing!"
    if is_shouting:
        return "Whoa, chill out!"
    if is_question:
        return "Sure."
    return "Whatever."
