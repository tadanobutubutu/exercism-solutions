#!/usr/bin/env bash

# The following comments should help you get started:
# - Bash is flexible. You may use functions or write a "raw" script.
#
# - Complex code can be made easier to read by breaking it up
#   into functions, however this is sometimes overkill in bash.
#
# - You can find links about good style and other resources
#   for Bash in './README.md'. It came with this exercise.
#
#   Example:
#   # other functions here
#   # ...
#   # ...
#
#   main () {
#     # your main function code here
#   }
#
#   # call main with all of the positional arguments
#   main "$@"
#
# *** PLEASE REMOVE THESE COMMENTS BEFORE SUBMITTING YOUR SOLUTION ***
#!/usr/bin/env bash

parse_list() {
    local raw=${1#\[}
    raw=${raw%\]}
    local output_name=$2
    eval "$output_name=()"
    [[ $raw =~ ^[[:space:]]*$ ]] && return
    local -a parts=()
    IFS=, read -r -a parts <<< "$raw"
    local item
    for item in "${parts[@]}"; do
        item=${item##+([[:space:]])}
        item=${item%%+([[:space:]])}
        eval "$output_name+=(\"$item\")"
    done
}

contains_sequence() {
    local haystack_name=$1 needle_name=$2
    local n haystack_length start i match hay_value needle_value
    eval "n=\${#${needle_name}[@]}"
    eval "haystack_length=\${#${haystack_name}[@]}"
    ((n == 0)) && return 0
    ((n <= haystack_length)) || return 1
    for ((start=0; start<=haystack_length-n; start++)); do
        match=1
        for ((i=0; i<n; i++)); do
            eval "hay_value=\${${haystack_name}[${start}+${i}]}"
            eval "needle_value=\${${needle_name}[${i}]}"
            [[ $hay_value == "$needle_value" ]] || { match=0; break; }
        done
        ((match)) && return 0
    done
    return 1
}

main() {
    local -a first=() second=()
    parse_list "${1:-[]}" first
    parse_list "${2:-[]}" second
    if [[ ${first[*]} == "${second[*]}" ]] && ((${#first[@]} == ${#second[@]})); then
        echo equal
    elif contains_sequence second first; then
        echo sublist
    elif contains_sequence first second; then
        echo superlist
    else
        echo unequal
    fi
}

shopt -s extglob
main "$@"
