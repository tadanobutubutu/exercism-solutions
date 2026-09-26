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
    local input=${1:-} normalized sum=0 i char value
    normalized=${input//-/}
    [[ ${#normalized} == 10 && $normalized =~ ^[0-9]{9}[0-9X]$ ]] || { echo false; return 0; }
    for ((i=0; i<10; i++)); do
        char=${normalized:i:1}
        if [[ $char == X ]]; then value=10; else value=$char; fi
        sum=$((sum + value * (10-i)))
    done
    if ((sum % 11 == 0)); then echo true; else echo false; fi
}

main "$@"
