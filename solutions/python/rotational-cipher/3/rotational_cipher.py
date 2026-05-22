def rotate(text, key):
    res = ""
    for char in text:
        if char.isalpha():
            start = ord('a') if char.islower() else ord('A')
            res += chr((ord(char) - start + key) % 26 + start)
        else:
            res += char
    return res
