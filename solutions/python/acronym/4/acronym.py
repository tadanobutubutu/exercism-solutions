def abbreviate(words: str) -> str:
    """
    Convert a phrase to its acronym.
    
    Args:
        words: The input phrase to convert.
    
    Returns:
        str: The acronym of the input phrase.
    """
    acronym = []
    for word in words.split():
        # Remove punctuation and take the first letter of each word
        cleaned_word = ''.join(char for char in word if char.isalnum() or char == "-")
        if cleaned_word:
            acronym.append(cleaned_word[0].upper())
    return ''.join(acronym)