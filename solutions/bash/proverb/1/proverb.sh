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
    local count=$# i
    ((count == 0)) && return 0
    local -a items=("$@")
    for ((i=0; i<count-1; i++)); do
        printf 'For want of a %s the %s was lost.\n' "${items[i]}" "${items[i+1]}"
    done
    printf 'And all for the want of a %s.\n' "$1"
}

main "$@"
