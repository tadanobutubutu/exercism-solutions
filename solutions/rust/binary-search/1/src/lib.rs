pub fn find(array: &[i32], key: i32) -> Option<usize> {
    let mut left = 0;
    let mut right = array.len();
    while left < right {
        let middle = left + (right - left) / 2;
        match array[middle].cmp(&key) {
            std::cmp::Ordering::Less => left = middle + 1,
            std::cmp::Ordering::Greater => right = middle,
            std::cmp::Ordering::Equal => return Some(middle),
        }
    }
    None
}
