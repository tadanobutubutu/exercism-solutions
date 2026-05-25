def is_isogram(string):
    cleaned_string = ''.join(c.lower() for c in string if c.isalpha())
    return len(cleaned_string) == len(set(cleaned_string))
