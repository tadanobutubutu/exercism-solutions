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
    local value=${1:-}
    [[ $value =~ ^[0-9]+$ ]] || return 1
    value=$((10#$value))
    local low=0 high=$((value + 1)) mid
    while ((high - low > 1)); do
        mid=$(((low + high) / 2))
        if ((mid <= value / mid)); then low=$mid; else high=$mid; fi
    done
    echo "$low"
}

main "$@"
