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

translate_word() {
    local word=$1 prefix_length=0 char next i
    if [[ $word =~ ^[aeiou] || $word =~ ^xr || $word =~ ^yt ]]; then echo "${word}ay"; return; fi
    for ((i=0; i<${#word};)); do
        char=${word:i:1}
        if [[ $char == q && ${word:i+1:1} == u ]]; then prefix_length=$((i+2)); i=$((i+2)); continue; fi
        if [[ $char =~ [aeiou] ]] || { [[ $char == y ]] && ((i > 0)); }; then prefix_length=$i; break; fi
        i=$((i+1))
        prefix_length=$i
    done
    if ((prefix_length == ${#word})); then echo "${word}ay"
    else echo "${word:prefix_length}${word:0:prefix_length}ay"
    fi
}

main() {
    local -a result=()
    local word
    for word in "$@"; do result+=("$(translate_word "$word")"); done
    local IFS=' '
    echo "${result[*]}"
}

main "$@"
