from collections import Counter

def find_anagrams(word: str, candidates: list[str]) -> list[str]:
    # Convert the word to lowercase and count the letters
    word_lower = word.lower()
    word_count = Counter(word_lower)
    
    # Initialize a list to store the anagrams
    anagrams = []
    
    # Iterate over the candidates
    for candidate in candidates:
        # Convert the candidate to lowercase and count the letters
        candidate_lower = candidate.lower()
        candidate_count = Counter(candidate_lower)
        
        # Check if the candidate is an anagram of the word
        if candidate_count == word_count and candidate_lower != word_lower:
            anagrams.append(candidate)
    
    return anagrams