#!/usr/bin/env bash

main () {
    local n=$1 factors=""

    local factor=2
    while (( n > 1 )); do
        if (( n % factor == 0 )); then
            factors+="$factor "
            (( n /= factor ))
        else
            ((factor++))
        fi
    done

    echo "${factors% }"
}

main "$@"
