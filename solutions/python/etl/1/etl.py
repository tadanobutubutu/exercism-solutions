def transform(legacy_data):
    res = {}
    for score, letters in legacy_data.items():
        for letter in letters:
            res[letter.lower()] = score
    return res
