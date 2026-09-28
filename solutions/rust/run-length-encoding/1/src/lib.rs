pub fn encode(source: &str) -> String {
    let mut encoded = String::new();
    let mut characters = source.chars().peekable();
    while let Some(character) = characters.next() {
        let mut count = 1usize;
        while characters.peek() == Some(&character) {
            characters.next();
            count += 1;
        }
        if count > 1 {
            encoded.push_str(&count.to_string());
        }
        encoded.push(character);
    }
    encoded
}

pub fn decode(source: &str) -> String {
    let mut decoded = String::new();
    let mut count = 0usize;
    for character in source.chars() {
        if character.is_ascii_digit() {
            count = count * 10 + character.to_digit(10).unwrap() as usize;
        } else {
            let repetitions = if count == 0 { 1 } else { count };
            decoded.extend(std::iter::repeat_n(character, repetitions));
            count = 0;
        }
    }
    decoded
}
