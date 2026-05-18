import string

def is_pangram(sentence):
    alphabet = set(string.ascii_lowercase)
    letters_in_sentence = set(sentence.lower())
    return alphabet.issubset(letters_in_sentence)
