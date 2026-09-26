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
    (($# >= 1)) || { echo -1; return 0; }
    local target=$1
    shift
    local -a values=("$@")
    local low=0 high=$((${#values[@]} - 1)) mid
    while ((low <= high)); do
        mid=$(((low + high) / 2))
        if ((values[mid] == target)); then echo "$mid"; return 0
        elif ((values[mid] < target)); then low=$((mid + 1))
        else high=$((mid - 1))
        fi
    done
    echo -1
}

main "$@"
