/// Determine whether a sentence is a pangram.
pub fn is_pangram(sentence: &str) -> bool {
    let mut letters = [false; 26];
    for byte in sentence.bytes().filter(u8::is_ascii_alphabetic) {
        letters[(byte.to_ascii_lowercase() - b'a') as usize] = true;
    }
    letters.into_iter().all(|found| found)
}
