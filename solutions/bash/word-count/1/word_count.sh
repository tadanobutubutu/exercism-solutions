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

record_word() {
    local word=$1 i
    [[ -n $word ]] || return 0
    for i in "${!words[@]}"; do
        if [[ ${words[i]} == "$word" ]]; then counts[i]=$((counts[i] + 1)); return 0; fi
    done
    words+=("$word")
    counts+=(1)
}

main() {
    local input char next token='' i
    input=$(printf '%s' "${1:-}" | tr '[:upper:]' '[:lower:]')
    local -a words=() counts=()
    for ((i=0; i<${#input}; i++)); do
        char=${input:i:1}
        if [[ $char =~ ^[a-z0-9]$ ]]; then
            token+=$char
        elif [[ $char == "'" && -n $token ]]; then
            next=${input:i+1:1}
            if [[ $next =~ ^[a-z0-9]$ ]]; then token+=$char
            else record_word "$token"; token=''
            fi
        else
            record_word "$token"
            token=''
        fi
    done
    record_word "$token"
    for i in "${!words[@]}"; do printf '%s: %s\n' "${words[i]}" "${counts[i]}"; done
}

main "$@"
