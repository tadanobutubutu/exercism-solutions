from collections import defaultdict

def find_anagrams(word: str, candidates: list[str]) -> list[str]:
    """
    Find all anagrams of the given word in the list of candidates.
    
    Args:
        word: The target word to find anagrams for.
        candidates: A list of candidate words to check.
    
    Returns:
        list[str]: A list of anagrams of the target word.
    """
    word_lower = word.lower()
    word_sorted = sorted(word_lower)
    anagrams = []
    
    for candidate in candidates:
        candidate_lower = candidate.lower()
        if candidate_lower == word_lower:
            continue
        if sorted(candidate_lower) == word_sorted:
            anagrams.append(candidate)
    
    return anagrams