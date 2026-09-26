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

decimal() {
    if [[ $1 == -* ]]; then printf '%s' "$((-1 * 10#${1#-}))"; else printf '%s' "$((10#$1))"; fi
}

normalize() {
    local value=$(( $(decimal "$1") * 60 + $(decimal "$2") ))
    echo $(((value % 1440 + 1440) % 1440))
}

main() {
    local total other delta
    if (($# == 2)); then
        [[ $1 =~ ^-?[0-9]+$ && $2 =~ ^-?[0-9]+$ ]] || { echo "invalid numeric arguments"; return 1; }
        total=$(normalize "$1" "$2")
    elif (($# == 4)) && [[ $3 == + || $3 == - ]]; then
        [[ $1 =~ ^-?[0-9]+$ && $2 =~ ^-?[0-9]+$ && $4 =~ ^[0-9]+$ ]] || { echo "invalid numeric arguments"; return 1; }
        total=$(normalize "$1" "$2")
        delta=$((10#$4))
        if [[ $3 == - ]]; then total=$((total - delta)); else total=$((total + delta)); fi
        total=$(((total % 1440 + 1440) % 1440))
    elif (($# == 5)) && [[ $3 == = ]]; then
        [[ $1 =~ ^-?[0-9]+$ && $2 =~ ^-?[0-9]+$ && $4 =~ ^-?[0-9]+$ && $5 =~ ^-?[0-9]+$ ]] || { echo "invalid numeric arguments"; return 1; }
        total=$(normalize "$1" "$2")
        other=$(normalize "$4" "$5")
        if ((total == other)); then echo true; else echo false; fi
        return 0
    else
        echo "invalid arguments"
        return 1
    fi
    printf '%02d:%02d\n' "$((total / 60))" "$((total % 60))"
}

main "$@"
