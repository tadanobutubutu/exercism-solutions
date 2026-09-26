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
    [[ $number =~ ^[0-9]+$ ]] || return 1
    number=$((10#$number))
    ((number >= 1 && number <= 3999)) || return 1
    local -a values=(1000 900 500 400 100 90 50 40 10 9 5 4 1)
    local -a symbols=(M CM D CD C XC L XL X IX V IV I)
    local result='' i
    for i in "${!values[@]}"; do
        while ((number >= values[i])); do result+="${symbols[i]}"; number=$((number-values[i])); done
    done
    echo "$result"
}

main "$@"
