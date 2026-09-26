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
    local -a colors=(black brown red orange yellow green blue violet grey white)
    local first=${1:-} second=${2:-} first_value second_value i color argument_index
    for argument_index in 0 1; do
        if ((argument_index == 0)); then color=$first; else color=$second; fi
        local found=0
        for i in "${!colors[@]}"; do
            if [[ ${colors[i]} == "$color" ]]; then found=1; break; fi
        done
        ((found)) || { echo "invalid color: $color" >&2; return 1; }
        if ((argument_index == 0)); then first_value=$i; else second_value=$i; fi
    done
    echo $((first_value * 10 + second_value))
}

main "$@"
