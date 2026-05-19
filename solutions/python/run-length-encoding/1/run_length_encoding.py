import re

def decode(string):
    if not string:
        return ""
    
    # 正規表現を修正: 文字以外のものもグループ化できるように
    parts = re.findall(r'(\d+)?(.)', string)
    result = ""
    for count, char in parts:
        if count:
            result += char * int(count)
        else:
            result += char
    return result

def encode(string):
    if not string:
        return ""
    
    # 修正: 文字列全体から繰り返しを見つけるのではなく、
    # 直前の文字と比較してカウントする
    result = ""
    if not string:
        return ""
        
    i = 0
    while i < len(string):
        count = 1
        while i + 1 < len(string) and string[i] == string[i+1]:
            count += 1
            i += 1
        if count > 1:
            result += str(count) + string[i]
        else:
            result += string[i]
        i += 1
    return result
