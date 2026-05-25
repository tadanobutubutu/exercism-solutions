#!/usr/bin/env bash

main () {
    if [[ $# -ne 2 ]]; then
        echo "error: need 2 arguments"
        exit 1
    fi

    local x=$1 y=$2

    if ! [[ $x =~ ^-?[0-9]+([.][0-9]+)?$ ]] || ! [[ $y =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
        echo "error: non-numeric argument"
        exit 1
    fi

    local distance
    distance=$(bc -l <<< "sqrt($x * $x + $y * $y)")

    if (( $(echo "$distance > 10" | bc -l) )); then
        echo 0
    elif (( $(echo "$distance > 5" | bc -l) )); then
        echo 1
    elif (( $(echo "$distance > 1" | bc -l) )); then
        echo 5
    else
        echo 10
    fi
}

main "$@"
