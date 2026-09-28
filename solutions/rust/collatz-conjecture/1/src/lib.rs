pub fn collatz(n: u64) -> Option<u64> {
    if n == 0 {
        return None;
    }

    let mut value = n;
    let mut steps: u64 = 0;
    while value != 1 {
        value = if value % 2 == 0 {
            value / 2
        } else {
            value.checked_mul(3)?.checked_add(1)?
        };
        steps = steps.checked_add(1)?;
    }
    Some(steps)
}
