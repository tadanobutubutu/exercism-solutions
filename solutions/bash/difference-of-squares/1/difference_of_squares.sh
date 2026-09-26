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
    local operation=${1:-} n=${2:-}
    [[ $n =~ ^[0-9]+$ ]] || return 1
    n=$((10#$n))
    case "$operation" in
        square_of_sum)
            local sum=$((n * (n + 1) / 2))
            echo $((sum * sum))
            ;;
        sum_of_squares)
            echo $((n * (n + 1) * (2 * n + 1) / 6))
            ;;
        difference)
            local sum=$((n * (n + 1) / 2))
            echo $((sum * sum - n * (n + 1) * (2 * n + 1) / 6))
            ;;
        *) return 1 ;;
    esac
}

main "$@"
