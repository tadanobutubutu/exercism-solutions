#!/usr/bin/env bash

main () {
    if [[ $# -ne 2 ]]; then
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
    fi

    local strand1=$1 strand2=$2

    if [[ ${#strand1} -ne ${#strand2} ]]; then
        echo "strands must be of equal length"
        exit 1
    fi

    local distance=0
    for ((i = 0; i < ${#strand1}; i++)); do
        [[ "${strand1:$i:1}" != "${strand2:$i:1}" ]] && ((distance++))
    done

    echo "$distance"
}

main "$@"
