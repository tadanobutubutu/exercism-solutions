pub fn factors(n: u64) -> Vec<u64> {
    if n < 2 {
        return Vec::new();
    }

    let mut remaining = n;
    let mut result = Vec::new();
    while remaining % 2 == 0 {
        result.push(2);
        remaining /= 2;
    }

    let mut divisor = 3_u64;
    while divisor <= remaining / divisor {
        while remaining % divisor == 0 {
            result.push(divisor);
            remaining /= divisor;
        }
        divisor += 2;
    }

    if remaining > 1 {
        result.push(remaining);
    }
    result
}
