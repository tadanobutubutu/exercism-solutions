def find_anagrams(word, candidates):
    word_lower = word.lower()
    word_sorted = sorted(word_lower)
    res = []
    for cand in candidates:
        cand_lower = cand.lower()
        if cand_lower != word_lower and sorted(cand_lower) == word_sorted:
            res.append(cand)
    return res
