#!/usr/bin/env bash

main () {
    local sentence=$(echo "$1" | tr '[:upper:]' '[:lower:]')
    local result="true"

    for letter in {a..z}; do
        if [[ "$sentence" != *"$letter"* ]]; then
            result="false"
            break
        fi
    done

    echo "$result"
}

main "$@"
