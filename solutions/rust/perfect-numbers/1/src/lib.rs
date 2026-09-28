#[derive(Debug, PartialEq, Eq)]
pub enum Classification {
    Abundant,
    Perfect,
    Deficient,
}

pub fn classify(num: u64) -> Option<Classification> {
    if num == 0 {
        return None;
    }

    let mut aliquot_sum = if num > 1 { 1 } else { 0 };
    let mut divisor = 2;
    while divisor <= num / divisor {
        if num % divisor == 0 {
            aliquot_sum += divisor;
            let paired_divisor = num / divisor;
            if paired_divisor != divisor {
                aliquot_sum += paired_divisor;
            }
        }
        divisor += 1;
    }

    Some(match aliquot_sum.cmp(&num) {
        std::cmp::Ordering::Less => Classification::Deficient,
        std::cmp::Ordering::Equal => Classification::Perfect,
        std::cmp::Ordering::Greater => Classification::Abundant,
    })
}
