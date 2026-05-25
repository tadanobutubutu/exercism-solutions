#!/usr/bin/env bash

main () {
    local type=$1 a=$2 b=$3 c=$4

    if ! [[ $a =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $b =~ ^[0-9]+([.][0-9]+)?$ ]] || ! [[ $c =~ ^[0-9]+([.][0-9]+)?$ ]]; then
        echo "false"
        exit 0
    fi

    if (( $(echo "$a + $b <= $c || $a + $c <= $b || $b + $c <= $a" | bc -l) )); then
        echo "false"
        return
    fi

    case "$type" in
        equilateral)
            if (( $(echo "$a == $b && $b == $c" | bc -l) )); then echo "true"; else echo "false"; fi
            ;;
        isosceles)
            if (( $(echo "$a == $b || $a == $c || $b == $c" | bc -l) )); then echo "true"; else echo "false"; fi
            ;;
        scalene)
            if (( $(echo "$a != $b && $a != $c && $b != $c" | bc -l) )); then echo "true"; else echo "false"; fi
            ;;
    esac
}

main "$@"
