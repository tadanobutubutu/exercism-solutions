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
    local input=${1:-} char expected top i
    local -a stack=()
    for ((i=0; i<${#input}; i++)); do
        char=${input:i:1}
        case $char in
            '('|'['|'{') stack+=("$char") ;;
            ')'|']'|'}')
                ((${#stack[@]})) || { echo false; return 0; }
                top=${stack[${#stack[@]}-1]}
                stack=("${stack[@]:0:${#stack[@]}-1}")
                case $char in
                    ')') expected='(' ;;
                    ']') expected='[' ;;
                    '}') expected='{' ;;
                esac
                [[ $top == "$expected" ]] || { echo false; return 0; }
                ;;
        esac
    done
    if ((${#stack[@]} == 0)); then echo true; else echo false; fi
}

main "$@"
