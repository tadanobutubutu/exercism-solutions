def transpose(text):
    if not text:
        return ""
    rows = text.split("\n")
    max_len = max(len(r) for r in rows)
    result = []
    for col in range(max_len):
        last = max(i for i, r in enumerate(rows) if col < len(r))
        line = ""
        for i in range(last + 1):
            line += rows[i][col] if col < len(rows[i]) else " "
        result.append(line)
    return "\n".join(result)