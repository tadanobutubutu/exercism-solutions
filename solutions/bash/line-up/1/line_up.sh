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
    local name=${1:-} number=${2:-} suffix last_two last_digit
    [[ $number =~ ^[0-9]+$ ]] || return 1
    number=$((10#$number))
    ((number >= 1 && number <= 999)) || return 1
    last_two=$((number % 100))
    last_digit=$((number % 10))
    if ((last_two >= 11 && last_two <= 13)); then
        suffix=th
    else
        case $last_digit in
            1) suffix=st ;;
            2) suffix=nd ;;
            3) suffix=rd ;;
            *) suffix=th ;;
        esac
    fi
    printf '%s, you are the %s%s customer we serve today. Thank you!\n' "$name" "$number" "$suffix"
}

main "$@"
