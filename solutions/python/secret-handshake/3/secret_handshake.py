def commands(binary_str):
    actions = ["wink", "double blink", "close your eyes", "jump"]
    res = []
    
    for i in range(4):
        if binary_str[4 - i] == '1':
            res.append(actions[i])
            
    if binary_str[0] == '1':
        res.reverse()
        
    return res
