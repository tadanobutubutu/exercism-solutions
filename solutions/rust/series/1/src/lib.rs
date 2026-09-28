pub fn series(digits: &str, len: usize) -> Vec<String> {
    let characters: Vec<char> = digits.chars().collect();
    if len == 0 || len > characters.len() {
        return Vec::new();
    }
    characters
        .windows(len)
        .map(|window| window.iter().collect())
        .collect()
}
