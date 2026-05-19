COLORS = [
    "black",
    "brown",
    "red",
    "orange",
    "yellow",
    "green",
    "blue",
    "violet",
    "grey",
    "white",
]

def label(colors):
    val = (COLORS.index(colors[0]) * 10 + COLORS.index(colors[1])) * (10 ** COLORS.index(colors[2]))
    
    if val >= 1_000_000_000:
        return f"{val // 1_000_000_000} gigaohms"
    if val >= 1_000_000:
        return f"{val // 1_000_000} megaohms"
    if val >= 1_000:
        return f"{val // 1_000} kiloohms"
    return f"{val} ohms"
