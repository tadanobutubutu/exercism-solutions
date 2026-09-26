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
    local input=${1:-} digits
    local error='Invalid number.  [1]NXX-NXX-XXXX N=2-9, X=0-9'
    [[ $input =~ ^[+()0-9.[:space:]-]+$ ]] || { echo "$error"; return 1; }
    digits=$(printf '%s' "$input" | tr -cd '0-9')
    if ((${#digits} == 11)) && [[ ${digits:0:1} == 1 ]]; then digits=${digits:1}; fi
    if [[ $digits =~ ^[2-9][0-9]{2}[2-9][0-9]{6}$ ]]; then
        echo "$digits"
    else
        echo "$error"
        return 1
    fi
}

main "$@"
