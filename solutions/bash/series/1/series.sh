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
    local series=${1:-} span=${2:-}
    [[ -n $series ]] || { echo "series cannot be empty"; return 1; }
    [[ $span =~ ^-?[0-9]+$ ]] || { echo "slice length must be an integer"; return 1; }
    [[ $span != -* ]] || { echo "slice length cannot be negative"; return 1; }
    span=$((10#$span))
    ((span > 0)) || { echo "slice length cannot be zero"; return 1; }
    ((span <= ${#series})) || { echo "slice length cannot be greater than series length"; return 1; }
    local start
    local -a slices=()
    for ((start=0; start<=${#series}-span; start++)); do
        slices+=("${series:start:span}")
    done
    local IFS=' '
    echo "${slices[*]}"
}

main "$@"
