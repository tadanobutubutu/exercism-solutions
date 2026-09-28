pub fn abbreviate(phrase: &str) -> String {
    let mut acronym = String::new();
    let mut in_word = false;
    let mut previous = None;

    for character in phrase.chars() {
        if character.is_whitespace() || character == '-' {
            in_word = false;
            previous = None;
            continue;
        }
        if !character.is_alphanumeric() {
            continue;
        }

        let starts_camel_word = in_word
            && character.is_uppercase()
            && previous.is_some_and(char::is_lowercase);
        if !in_word || starts_camel_word {
            acronym.extend(character.to_uppercase());
        }
        in_word = true;
        previous = Some(character);
    }

    acronym
}
