#!/usr/bin/env bash

main () {
    local word=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local score=0

    for ((i = 0; i < ${#word}; i++)); do
        local c="${word:$i:1}"
        case "$c" in
            [aeioulnrst]) ((score += 1)) ;;
            [dg])         ((score += 2)) ;;
            [bcmp])       ((score += 3)) ;;
            [fhvwy])      ((score += 4)) ;;
            k)            ((score += 5)) ;;
            [jx])         ((score += 8)) ;;
            [qz])         ((score += 10)) ;;
        esac
    done

    echo "$score"
}

main "$@"
