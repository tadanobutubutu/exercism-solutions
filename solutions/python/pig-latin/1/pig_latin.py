import re

def translate(text):
    words = text.split()
    res = []
    for word in words:
        res.append(translate_word(word))
    return " ".join(res)

def translate_word(word):
    # Rule 1: Starts with vowel sound
    if re.match(r"^([aeiou]|xr|yt)", word):
        return word + "ay"
    
    # Rule 3: Starts with consonants followed by "qu"
    match = re.match(r"^([^aeiou]*qu)(.*)", word)
    if match:
        return match.group(2) + match.group(1) + "ay"
    
    # Rule 4: Starts with consonants followed by "y"
    match = re.match(r"^([^aeiou]+)(y.*)", word)
    if match:
        return match.group(2) + match.group(1) + "ay"
        
    # Rule 2: Starts with consonants
    match = re.match(r"^([^aeiou]+)(.*)", word)
    if match:
        return match.group(2) + match.group(1) + "ay"
        
    return word + "ay"
