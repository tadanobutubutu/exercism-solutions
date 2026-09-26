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
    local input=${1:-} digits sum=0 index digit doubled double=0
    digits=${input// /}
    if ((${#digits} <= 1)) || [[ ! $digits =~ ^[0-9]+$ ]]; then echo false; return 0; fi
    for ((index=${#digits}-1; index>=0; index--)); do
        digit=${digits:index:1}
        digit=$((10#$digit))
        if ((double)); then
            doubled=$((digit * 2))
            ((doubled > 9)) && doubled=$((doubled - 9))
            digit=$doubled
        fi
        sum=$((sum + digit))
        double=$((1 - double))
    done
    if ((sum % 10 == 0)); then echo true; else echo false; fi
}

main "$@"
