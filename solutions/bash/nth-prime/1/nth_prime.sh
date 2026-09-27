#!/usr/bin/env bash

n=${1:-}
if [[ ! $n =~ ^[0-9]+$ ]] || ((10#$n < 1)); then
    echo "invalid input"
    exit 1
fi
n=$((10#$n))
primes=(2)
candidate=3
while ((${#primes[@]} < n)); do
    is_prime=1
    for ((j=0; j<${#primes[@]}; j++)); do
        prime=${primes[j]}
        ((prime*prime > candidate)) && break
        if ((candidate%prime == 0)); then is_prime=0; break; fi
    done
    ((is_prime)) && primes+=("$candidate")
    ((candidate+=2))
done
echo "${primes[n-1]}"
