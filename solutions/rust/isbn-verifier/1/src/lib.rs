/// Determines whether the supplied string is a valid ISBN number
pub fn is_valid_isbn(isbn: &str) -> bool {
    let characters: Vec<char> = isbn.chars().filter(|&character| character != '-').collect();
    if characters.len() != 10 {
        return false;
    }

    let mut sum = 0u32;
    for (index, character) in characters.iter().enumerate() {
        let value = match *character {
            '0'..='9' => character.to_digit(10).unwrap(),
            'X' if index == 9 => 10,
            _ => return false,
        };
        sum += value * (10 - index as u32);
    }
    sum % 11 == 0
}
