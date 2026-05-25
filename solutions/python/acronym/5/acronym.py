def abbreviate(phrase: str) -> str:
    # Split the phrase into words using hyphens and whitespace as separators
    words = [word.strip("\'\"!@#$%^&*()_+-=[]{}|;:,.<>?/") for word in phrase.replace("-", " ").split()]
    # Extract the first letter of each word and convert to uppercase
    acronym = ''.join(word[0].upper() for word in words if word)
    return acronym