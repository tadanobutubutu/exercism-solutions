import re

def abbreviate(words):
    # Split by spaces, hyphens, and underscores
    parts = re.findall(r"[A-Z']+", words.upper())
    return "".join(word[0] for word in parts if word[0].isalpha())
