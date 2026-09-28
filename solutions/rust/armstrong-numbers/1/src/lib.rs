pub fn is_armstrong_number(num: u32) -> bool {
    let digits: Vec<u32> = num
        .to_string()
        .bytes()
        .map(|digit| u32::from(digit - b'0'))
        .collect();
    let power = digits.len() as u32;
    let sum: u64 = digits
        .into_iter()
        .map(|digit| u64::from(digit).pow(power))
        .sum();
    sum == u64::from(num)
}
