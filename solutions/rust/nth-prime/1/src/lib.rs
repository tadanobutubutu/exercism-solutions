pub fn nth(n: u32) -> u32 {
    let mut primes = Vec::with_capacity(n as usize + 1);
    let mut candidate = 2_u32;
    while primes.len() <= n as usize {
        let is_prime = primes
            .iter()
            .take_while(|&&prime| prime * prime <= candidate)
            .all(|&prime| candidate % prime != 0);
        if is_prime {
            primes.push(candidate);
        }
        candidate += 1;
    }
    primes[n as usize]
}
