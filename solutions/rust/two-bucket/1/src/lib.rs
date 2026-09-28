#[derive(PartialEq, Eq, Debug)]
pub enum Bucket {
    One,
    Two,
}

/// A struct to hold your results in.
#[derive(PartialEq, Eq, Debug)]
pub struct BucketStats {
    /// The total number of "moves" it should take to reach the desired number of liters, including
    /// the first fill.
    pub moves: u8,
    /// Which bucket should end up with the desired number of liters? (Either "one" or "two")
    pub goal_bucket: Bucket,
    /// How many liters are left in the other bucket?
    pub other_bucket: u8,
}

/// Solve the bucket problem
pub fn solve(
    capacity_1: u8,
    capacity_2: u8,
    goal: u8,
    start_bucket: &Bucket,
) -> Option<BucketStats> {
    use std::collections::{HashSet, VecDeque};

    if goal > capacity_1.max(capacity_2)
        || (goal != 0 && goal % gcd(capacity_1, capacity_2) != 0)
    {
        return None;
    }

    let starting_with_one = matches!(start_bucket, Bucket::One);
    let initial = if starting_with_one {
        (capacity_1, 0)
    } else {
        (0, capacity_2)
    };
    let mut queue = VecDeque::from([(initial.0, initial.1, 1u16)]);
    let mut visited = HashSet::from([initial]);

    while let Some((one, two, moves)) = queue.pop_front() {
        if one == goal || two == goal {
            return Some(BucketStats {
                moves: u8::try_from(moves).ok()?,
                goal_bucket: if one == goal { Bucket::One } else { Bucket::Two },
                other_bucket: if one == goal { two } else { one },
            });
        }

        let candidates = [
            (capacity_1, two),
            (one, capacity_2),
            (0, two),
            (one, 0),
            {
                let amount = one.min(capacity_2 - two);
                (one - amount, two + amount)
            },
            {
                let amount = two.min(capacity_1 - one);
                (one + amount, two - amount)
            },
        ];

        for next in candidates {
            let forbidden = if starting_with_one {
                next.0 == 0 && next.1 == capacity_2
            } else {
                next.1 == 0 && next.0 == capacity_1
            };
            if !forbidden && visited.insert(next) {
                queue.push_back((next.0, next.1, moves + 1));
            }
        }
    }

    None
}

fn gcd(a: u8, b: u8) -> u8 {
    if b == 0 { a } else { gcd(b, a % b) }
}
