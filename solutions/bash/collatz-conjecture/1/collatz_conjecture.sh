#!/usr/bin/env bash

main () {
    local n=$1 steps=0

    if (( n <= 0 )); then
        echo "Error: Only positive numbers are allowed"
        exit 1
    fi

    while (( n != 1 )); do
        if (( n % 2 == 0 )); then
            (( n /= 2 ))
        else
            n=$(( 3 * n + 1 ))
        fi
        ((steps++))
    done

    echo "$steps"
}

main "$@"
