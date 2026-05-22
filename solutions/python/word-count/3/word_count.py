import re
from collections import Counter

def count_words(sentence):
    # Find words: alphanumeric or apostrophes between letters
    # This regex handles cases like "don't" but not lone apostrophes or at start/end
    # \b[a-z0-9]+(?:'[a-z0-9]+)?\b
    words = re.findall(r"[a-z0-9]+(?:'[a-z0-9]+)?", sentence.lower())
    return Counter(words)
