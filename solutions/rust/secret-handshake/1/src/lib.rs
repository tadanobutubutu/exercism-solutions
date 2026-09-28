pub fn actions(n: u8) -> Vec<&'static str> {
    let mut result = Vec::new();
    for (mask, action) in [
        (1, "wink"),
        (2, "double blink"),
        (4, "close your eyes"),
        (8, "jump"),
    ] {
        if n & mask != 0 {
            result.push(action);
        }
    }
    if n & 16 != 0 {
        result.reverse();
    }
    result
}
