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
    (($# >= 1)) || { echo 0; return 0; }
    local limit=$1 factor sum=0 number
    shift
    [[ $limit =~ ^[0-9]+$ ]] || return 1
    limit=$((10#$limit))
    local -a includes=() seen=()
    for factor in "$@"; do
        [[ $factor =~ ^[0-9]+$ ]] || return 1
        factor=$((10#$factor))
        ((factor > 0)) && includes+=("$factor")
    done
    for ((number=1; number<limit; number++)); do
        for factor in "${includes[@]}"; do
            if ((number % factor == 0)); then sum=$((sum + number)); break; fi
        done
    done
    echo "$sum"
}

main "$@"
