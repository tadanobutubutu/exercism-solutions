def abbreviate(phrase):
    """Convert a phrase to its acronym."""
    # Replace underscores and hyphens with spaces
    phrase = phrase.replace('_', ' ').replace('-', ' ')
    
    # Split by spaces and process each word
    words = []
    current_word = ""
    
    for i, char in enumerate(phrase):
        if char.isalpha() or (char == "'" and 0 < i < len(phrase) - 1):
            current_word += char
        else:
            if current_word:
                words.append(current_word)
                current_word = ""
    
    # Add the last word if it exists
    if current_word:
        words.append(current_word)
    
    # Take the first letter of each word and make it uppercase
    acronym = "".join(word[0].upper() for word in words if word)
    
    return acronym
