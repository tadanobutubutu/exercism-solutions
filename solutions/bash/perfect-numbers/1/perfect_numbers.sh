#!/usr/bin/env bash

main () {
    local n=$1 sum=0
    local sqrt

    if (( n <= 0 )); then
        echo "Classification is only possible for natural numbers."
        exit 1
    fi

    sqrt=$(bc <<< "sqrt($n)" | cut -d. -f1)

    for ((i = 1; i <= sqrt; i++)); do
        if (( n % i == 0 )); then
            local other=$(( n / i ))
            if (( i != n )); then
                ((sum += i))
            fi
            if (( other != i && other != n )); then
                ((sum += other))
            fi
        fi
    done

    if (( sum == n )); then
        echo "perfect"
    elif (( sum > n )); then
        echo "abundant"
    else
        echo "deficient"
    fi
}

main "$@"
