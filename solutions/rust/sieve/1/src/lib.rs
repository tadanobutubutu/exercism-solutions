pub fn primes_up_to(upper_bound: u64) -> Vec<u64> {
    if upper_bound < 2 {
        return Vec::new();
    }
    let limit = upper_bound as usize;
    let mut prime = vec![true; limit + 1];
    prime[0] = false;
    prime[1] = false;

    let mut candidate = 2usize;
    while candidate <= limit / candidate {
        if prime[candidate] {
            let mut multiple = candidate * candidate;
            while multiple <= limit {
                prime[multiple] = false;
                multiple += candidate;
            }
        }
        candidate += 1;
    }

    prime.iter().enumerate()
        .filter_map(|(number, &is_prime)| is_prime.then_some(number as u64))
        .collect()
}
