fn is_vowel(ch: u8) -> bool {
    matches!(ch, b'a' | b'e' | b'i' | b'o' | b'u')
}

fn translate_word(word: &str) -> String {
    let bytes = word.as_bytes();
    if word.starts_with("xr") || word.starts_with("yt") || is_vowel(bytes[0]) {
        return format!("{word}ay");
    }

    let mut split = 0;
    while split < bytes.len() {
        if bytes[split..].starts_with(b"qu") {
            split += 2;
            continue;
        }
        if is_vowel(bytes[split]) || (bytes[split] == b'y' && split > 0) {
            break;
        }
        split += 1;
    }

    format!("{}{}ay", &word[split..], &word[..split])
}

pub fn translate(input: &str) -> String {
    input
        .split_whitespace()
        .map(translate_word)
        .collect::<Vec<_>>()
        .join(" ")
}
