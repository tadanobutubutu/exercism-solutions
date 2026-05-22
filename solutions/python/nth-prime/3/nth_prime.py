def prime(number):
    if number < 1:
        raise ValueError("there is no zeroth prime")
    
    primes = []
    candidate = 2
    while len(primes) < number:
        for p in primes:
            if candidate % p == 0:
                break
        else:
            primes.append(candidate)
        candidate += 1
    return primes[-1]
