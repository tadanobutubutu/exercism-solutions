ONES = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
        "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen",
        "seventeen", "eighteen", "nineteen"]
TENS = ["", "", "twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]


def say(number):
    if number < 0 or number >= 10**12:
        raise ValueError("input out of range")
    if number == 0:
        return "zero"
    return _say(number).strip()


def _say(n):
    if n < 20:
        return ONES[n]
    if n < 100:
        t, o = divmod(n, 10)
        tens = TENS[t]
        ones = _say(o) if o else ""
        return f"{tens}-{ones}" if ones else tens
    if n < 1000:
        h, r = divmod(n, 100)
        head = f"{ONES[h]} hundred"
        rest = _say(r) if r else ""
        return f"{head} {rest}" if rest else head
    for unit, label in [(10**9, "billion"), (10**6, "million"), (10**3, "thousand")]:
        if n >= unit:
            q, r = divmod(n, unit)
            head = f"{_say(q)} {label}"
            rest = _say(r) if r else ""
            return f"{head} {rest}" if rest else head
    return ""