NUMBERS = {
    10: "Ten", 9: "Nine", 8: "Eight", 7: "Seven", 6: "Six",
    5: "Five", 4: "Four", 3: "Three", 2: "Two", 1: "One", 0: "No"
}

def recite(start, take=1):
    res = []
    for i in range(start, start - take, -1):
        if res:
            res.append("")
        res.extend(get_verse(i))
    return res

def get_verse(n):
    n_str = NUMBERS[n]
    next_n_str = NUMBERS[n-1].lower()
    
    bottle = "bottles" if n != 1 else "bottle"
    next_bottle = "bottles" if n-1 != 1 else "bottle"
    
    return [
        f"{n_str} green {bottle} hanging on the wall,",
        f"{n_str} green {bottle} hanging on the wall,",
        "And if one green bottle should accidentally fall,",
        f"There'll be {next_n_str} green {next_bottle} hanging on the wall."
    ]
