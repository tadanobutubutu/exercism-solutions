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
    local text=${1:-} shift=${2:-}
    [[ $shift =~ ^[0-9]+$ ]] || { echo "invalid shift" >&2; return 1; }
    shift=$((10#$shift % 26))
    local lower=abcdefghijklmnopqrstuvwxyz upper=ABCDEFGHIJKLMNOPQRSTUVWXYZ
    local rotated_lower=${lower:shift}${lower:0:shift}
    local rotated_upper=${upper:shift}${upper:0:shift}
    printf '%s\n' "$(printf '%s' "$text" | tr "$lower$upper" "$rotated_lower$rotated_upper")"
}

main "$@"
