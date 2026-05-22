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

TOLERANCE = {
    "grey": "0.05%",
    "violet": "0.1%",
    "blue": "0.25%",
    "green": "0.5%",
    "brown": "1%",
    "red": "2%",
    "gold": "5%",
    "silver": "10%",
}

def resistor_label(colors):
    if not colors:
        return "0 ohms"
    
    if len(colors) == 1:
        val = COLORS.index(colors[0])
        return f"{val} ohms"

    if len(colors) == 4:
        # [digit, digit, multiplier, tolerance]
        val = (COLORS.index(colors[0]) * 10 + COLORS.index(colors[1])) * (10 ** COLORS.index(colors[2]))
        tol = TOLERANCE[colors[3]]
    elif len(colors) == 5:
        # [digit, digit, digit, multiplier, tolerance]
        val = (COLORS.index(colors[0]) * 100 + COLORS.index(colors[1]) * 10 + COLORS.index(colors[2])) * (10 ** COLORS.index(colors[3]))
        tol = TOLERANCE[colors[4]]
    else:
        # This shouldn't happen based on rules but just in case
        val = (COLORS.index(colors[0]) * 10 + COLORS.index(colors[1])) * (10 ** COLORS.index(colors[2]))
        tol = "unknown"

    unit = "ohms"
    if val >= 1_000_000_000:
        val /= 1_000_000_000
        unit = "gigaohms"
    elif val >= 1_000_000:
        val /= 1_000_000
        unit = "megaohms"
    elif val >= 1_000:
        val /= 1_000
        unit = "kiloohms"
    
    # Check if val is effectively an integer
    if val == int(val):
        val = int(val)
        
    return f"{val} {unit} ±{tol}"
