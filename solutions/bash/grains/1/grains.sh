#!/usr/bin/env bash

main () {
    if [[ "$1" == "total" ]]; then
        echo "18446744073709551615"
        return
    fi

    local n=$1
    if (( n < 1 || n > 64 )); then
        echo "Error: invalid input"
        exit 1
    fi

    bc <<< "2^($n - 1)"
}

main "$@"
