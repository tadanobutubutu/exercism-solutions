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

main() {
    local code=${1:-0}
    [[ $code =~ ^[0-9]+$ ]] || return 1
    code=$((10#$code))
    local -a actions=()
    ((code & 1)) && actions+=(wink)
    ((code & 2)) && actions+=("double blink")
    ((code & 4)) && actions+=("close your eyes")
    ((code & 8)) && actions+=(jump)
    if ((code & 16)); then
        local -a reversed=()
        local i
        for ((i=${#actions[@]}-1; i>=0; i--)); do reversed+=("${actions[i]}"); done
        actions=("${reversed[@]}")
    fi
    local IFS=,
    printf '%s' "${actions[*]}"
    [[ ${#actions[@]} -gt 0 ]] && printf '\n'
    return 0
}

main "$@"
