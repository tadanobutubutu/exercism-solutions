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
    local mode=${1:-} text=${2:-} normalized transformed output='' char i
    shift 2 2>/dev/null || true
    if [[ $mode != encode && $mode != decode ]]; then echo "invalid mode" >&2; return 1; fi
    normalized=$(printf '%s' "$text" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]')
    transformed=$(printf '%s' "$normalized" | tr 'abcdefghijklmnopqrstuvwxyz' 'zyxwvutsrqponmlkjihgfedcba')
    if [[ $mode == decode ]]; then echo "$transformed"; return 0; fi
    for ((i=0; i<${#transformed}; i++)); do
        ((i > 0 && i % 5 == 0)) && output+=' '
        output+=${transformed:i:1}
    done
    echo "$output"
}

main "$@"
