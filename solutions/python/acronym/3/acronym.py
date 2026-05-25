def abbreviate(phrase: str) -> str:
    # Split the phrase into words using hyphens and whitespace as separators
    words = [word.strip("\"',.!?") for word in phrase.replace("-", " ").split()]
    # Create the acronym by taking the first letter of each word and converting it to uppercase
    acronym = ''.join(word[0].upper() for word in words if word)
    return acronym