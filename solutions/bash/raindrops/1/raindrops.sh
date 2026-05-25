#!/usr/bin/env bash

main () {
    local n=$1 result=""
    (( n % 3 == 0 )) && result+="Pling"
    (( n % 5 == 0 )) && result+="Plang"
    (( n % 7 == 0 )) && result+="Plong"
    echo "${result:-$n}"
}

main "$@"
