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
    local number=${1:-}
    [[ $number =~ ^[0-9]+$ ]] || { echo false; return; }
    local digits=${#number} sum=0 digit power i j
    for ((i=0; i<digits; i++)); do
        digit=$((10#${number:i:1}))
        power=1
        for ((j=0; j<digits; j++)); do power=$((power * digit)); done
        sum=$((sum + power))
    done
    if ((sum == 10#$number)); then echo true; else echo false; fi
}

main "$@"
