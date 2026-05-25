#!/usr/bin/env bash

main () {
    local phrase="$1"
    phrase=$(echo "$phrase" | tr '[:lower:]' '[:upper:]' | sed "s/'//g" | sed 's/[^A-Z]/ /g')
    local acronym=""
    local word

    for word in $phrase; do
        acronym+="${word:0:1}"
    done

    echo "$acronym"
}

main "$@"
