/// Return the Hamming distance between the strings,
/// or None if the lengths are mismatched.
pub fn hamming_distance(s1: &str, s2: &str) -> Option<usize> {
    if s1.chars().count() != s2.chars().count() {
        return None;
    }
    Some(
        s1.chars()
            .zip(s2.chars())
            .filter(|(left, right)| left != right)
            .count(),
    )
}
