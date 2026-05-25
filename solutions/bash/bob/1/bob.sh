#!/usr/bin/env bash

main () {
    local str="$*"

    local stripped="${str//[[:space:]]/}"
    if [[ -z "$stripped" ]]; then
        echo "Fine. Be that way!"
        return
    fi

    local trimmed="$str"
    trimmed=$(echo "$trimmed" | sed 's/[[:space:]]*$//')
    local last_char="${trimmed: -1}"

    local has_alpha=false
    local all_caps=false
    if [[ "$stripped" =~ [[:alpha:]] ]]; then
        has_alpha=true
        local upper
        upper=$(echo "$stripped" | tr '[:lower:]' '[:upper:]')
        [[ "$upper" == "$stripped" ]] && all_caps=true
    fi

    if $all_caps && [[ "$last_char" == "?" ]]; then
        echo "Calm down, I know what I'm doing!"
    elif [[ "$last_char" == "?" ]]; then
        echo "Sure."
    elif $all_caps && $has_alpha; then
        echo "Whoa, chill out!"
    else
        echo "Whatever."
    fi
}

main "$@"
