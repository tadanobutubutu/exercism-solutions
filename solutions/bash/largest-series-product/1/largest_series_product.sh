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
    local digits=${1:-} span=${2:-}
    if [[ $span == -* ]]; then
        echo "span must not be negative"
        return 1
    fi
    if [[ ! $span =~ ^[0-9]+$ ]]; then
        echo "span must be a non-negative integer"
        return 1
    fi
    span=$((10#$span))
    if [[ ! $digits =~ ^[0-9]*$ ]]; then
        echo "digits input must only contain digits"
        return 1
    fi
    if ((span > ${#digits})); then
        echo "span must not exceed string length"
        return 1
    fi
    if ((span == 0)); then echo 1; return; fi
    local max=0 start i product digit
    for ((start=0; start<=${#digits}-span; start++)); do
        product=1
        for ((i=start; i<start+span; i++)); do
            digit=$((10#${digits:i:1}))
            product=$((product * digit))
        done
        ((product > max)) && max=$product
    done
    echo "$max"
}

main "$@"
