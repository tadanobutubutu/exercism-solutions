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
    case ${1:-} in
        colors) printf '%s\n' "${colors[@]}" ;;
        code)
            local color=${2:-} i
            for i in "${!colors[@]}"; do
                if [[ ${colors[i]} == "$color" ]]; then echo "$i"; return; fi
            done
            echo "invalid color: $color" >&2
            return 1
            ;;
        *) echo "usage: resistor_color.sh colors | code COLOR" >&2; return 1 ;;
    esac
}

main "$@"
