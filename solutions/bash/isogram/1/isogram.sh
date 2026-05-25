#!/usr/bin/env bash

main () {
    local word=$(echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z]//g')
    local i char prefix

    for ((i = 0; i < ${#word}; i++)); do
        char="${word:$i:1}"
        prefix="${word:0:i}"
        if [[ "$prefix" == *"$char"* ]]; then
            echo "false"
            return
        fi
    done

    echo "true"
}

main "$@"
