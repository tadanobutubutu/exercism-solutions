/// Check a Luhn checksum.
pub fn is_valid(code: &str) -> bool {
    let mut digits = Vec::new();
    for byte in code.bytes() {
        match byte {
            b'0'..=b'9' => digits.push(byte - b'0'),
            b' ' => {}
            _ => return false,
        }
    }
    if digits.len() <= 1 {
        return false;
    }

    let sum: u32 = digits
        .iter()
        .rev()
        .enumerate()
        .map(|(index, digit)| {
            let value = u32::from(*digit);
            if index % 2 == 1 {
                let doubled = value * 2;
                if doubled > 9 { doubled - 9 } else { doubled }
            } else {
                value
            }
        })
        .sum();
    sum % 10 == 0
}
