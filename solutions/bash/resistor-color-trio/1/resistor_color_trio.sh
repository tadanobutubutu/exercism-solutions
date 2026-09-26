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
    local first=${1:-} second=${2:-} third=${3:-} i position value color found
    local -a values=()
    for position in 0 1 2; do
        case $position in
            0) color=$first ;;
            1) color=$second ;;
            2) color=$third ;;
        esac
        found=0
        for i in "${!colors[@]}"; do
            if [[ ${colors[i]} == "$color" ]]; then found=1; break; fi
        done
        if ((!found)); then echo "invalid color: $color" >&2; return 1; fi
        values+=("$i")
    done
    value=$(((values[0] * 10 + values[1]) * (10 ** values[2])))
    if ((value >= 1000000000)); then printf '%s gigaohms\n' "$((value / 1000000000))"
    elif ((value >= 1000000)); then printf '%s megaohms\n' "$((value / 1000000))"
    elif ((value >= 1000)); then printf '%s kiloohms\n' "$((value / 1000))"
    else printf '%s ohms\n' "$value"
    fi
}

main "$@"
