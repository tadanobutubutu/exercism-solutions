use std::collections::HashSet;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Palindrome {
    value: u64,
    factors: HashSet<(u64, u64)>,
}

impl Palindrome {
    pub fn value(&self) -> u64 {
        self.value
    }

    pub fn into_factors(self) -> HashSet<(u64, u64)> {
        self.factors
    }
}

fn is_palindrome(mut value: u64) -> bool {
    let original = value;
    let mut reversed = 0_u64;
    while value > 0 {
        let digit = value % 10;
        let Some(next) = reversed.checked_mul(10).and_then(|n| n.checked_add(digit)) else {
            return false;
        };
        reversed = next;
        value /= 10;
    }
    original == reversed
}

pub fn palindrome_products(min: u64, max: u64) -> Option<(Palindrome, Palindrome)> {
    if min > max {
        return None;
    }

    let mut smallest: Option<(u64, HashSet<(u64, u64)>)> = None;
    let mut largest: Option<(u64, HashSet<(u64, u64)>)> = None;

    for left in min..=max {
        for right in left..=max {
            let Some(product) = left.checked_mul(right) else {
                continue;
            };
            if !is_palindrome(product) {
                continue;
            }

            let pair = (left, right);
            match &mut smallest {
                Some((value, factors)) if product == *value => {
                    factors.insert(pair);
                }
                Some((value, factors)) if product < *value => {
                    *value = product;
                    factors.clear();
                    factors.insert(pair);
                }
                None => smallest = Some((product, HashSet::from([pair]))),
                _ => {}
            }
            match &mut largest {
                Some((value, factors)) if product == *value => {
                    factors.insert(pair);
                }
                Some((value, factors)) if product > *value => {
                    *value = product;
                    factors.clear();
                    factors.insert(pair);
                }
                None => largest = Some((product, HashSet::from([pair]))),
                _ => {}
            }
        }
    }

    let (min_value, min_factors) = smallest?;
    let (max_value, max_factors) = largest?;
    Some((
        Palindrome { value: min_value, factors: min_factors },
        Palindrome { value: max_value, factors: max_factors },
    ))
}
