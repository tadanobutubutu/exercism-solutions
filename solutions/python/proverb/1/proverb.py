def proverb(*args, qualifier=None):
    if not args:
        return []
    
    res = []
    for i in range(len(args) - 1):
        res.append(f"For want of a {args[i]} the {args[i+1]} was lost.")
        
    final_item = f"{qualifier} {args[0]}" if qualifier else args[0]
    res.append(f"And all for the want of a {final_item}.")
    
    return res
