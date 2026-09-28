use std::collections::HashSet;

pub fn anagrams_for<'a>(word: &str, possible_anagrams: &[&'a str]) -> HashSet<&'a str> {
    fn lowercase(word: &str) -> Vec<char> {
        word.chars().flat_map(char::to_lowercase).collect()
    }

    fn signature(word: &str) -> Vec<char> {
        let mut chars = lowercase(word);
        chars.sort_unstable();
        chars
    }

    let target_lowercase = lowercase(word);
    let target = signature(word);
    possible_anagrams
        .iter()
        .copied()
        .filter(|candidate| lowercase(candidate) != target_lowercase)
        .filter(|candidate| signature(candidate) == target)
        .collect()
}
