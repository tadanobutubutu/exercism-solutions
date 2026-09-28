pub fn check(candidate: &str) -> bool {
    use std::collections::HashSet;

    let mut seen = HashSet::new();
    candidate
        .chars()
        .filter(|character| character.is_alphabetic())
        .flat_map(char::to_lowercase)
        .all(|character| seen.insert(character))
}
