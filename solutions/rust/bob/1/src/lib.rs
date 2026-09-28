pub fn reply(message: &str) -> &str {
    let message = message.trim();
    if message.is_empty() {
        return "Fine. Be that way!";
    }

    let has_letters = message.chars().any(char::is_alphabetic);
    let is_shouting = has_letters
        && message
            .chars()
            .filter(|character| character.is_alphabetic())
            .all(char::is_uppercase);
    let is_question = message.ends_with('?');

    match (is_shouting, is_question) {
        (true, true) => "Calm down, I know what I'm doing!",
        (true, false) => "Whoa, chill out!",
        (false, true) => "Sure.",
        (false, false) => "Whatever.",
    }
}
