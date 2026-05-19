def transpose(text):
    if not text:
        return ""
    
    lines = text.splitlines()
    max_len = max(len(line) for line in lines)
    
    # Transpose logic with padding handling
    res = []
    for i in range(max_len):
        row = ""
        for j, line in enumerate(lines):
            if i < len(line):
                row += line[i]
            elif any(i < len(l) for l in lines[j+1:]):
                row += " "
        res.append(row)
        
    return "\n".join(res)
