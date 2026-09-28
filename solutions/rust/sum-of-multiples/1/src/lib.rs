pub fn sum_of_multiples(limit: u32, factors: &[u32]) -> u32 {
    fn gcd(mut a: u64, mut b: u64) -> u64 {
        while b != 0 {
            (a, b) = (b, a % b);
        }
        a
    }

    fn include_exclude(
        factors: &[u32],
        start: usize,
        current_lcm: u64,
        add: bool,
        limit: u64,
        total: &mut i128,
    ) {
        for index in start..factors.len() {
            let factor = u64::from(factors[index]);
            let lcm = (current_lcm / gcd(current_lcm, factor)) * factor;
            if lcm >= limit {
                continue;
            }

            let count = (limit - 1) / lcm;
            let sum = lcm * count * (count + 1) / 2;
            if add {
                *total += i128::from(sum);
            } else {
                *total -= i128::from(sum);
            }

            include_exclude(factors, index + 1, lcm, !add, limit, total);
        }
    }

    if limit <= 1 {
        return 0;
    }

    let mut factors: Vec<u32> = factors.iter().copied().filter(|&factor| factor > 0).collect();
    factors.sort_unstable();
    factors.dedup();

    let mut total = 0i128;
    include_exclude(&factors, 0, 1, true, u64::from(limit), &mut total);
    total as u32
}
