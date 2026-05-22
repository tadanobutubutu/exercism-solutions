def find_anagrams(word, candidates):
    word_lower = word.lower()
    word_sorted = sorted(word_lower)
    result = []
    for candidate in candidates:
        candidate_lower = candidate.lower()
        if candidate_lower == word_lower:
            continue
        if sorted(candidate_lower) == word_sorted:
            result.append(candidate)
    return result
