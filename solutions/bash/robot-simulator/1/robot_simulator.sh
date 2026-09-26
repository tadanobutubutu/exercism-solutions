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
    local x=0 y=0 direction=north instructions='' command orientation i
    if (($#)); then
        (($# >= 3 && $# <= 4)) || { echo "invalid arguments"; return 1; }
        x=$1; y=$2; direction=$3; instructions=${4:-}
        [[ $x =~ ^-?[0-9]+$ && $y =~ ^-?[0-9]+$ ]] || { echo "invalid position"; return 1; }
    fi
    local -a directions=(north east south west)
    for i in "${!directions[@]}"; do [[ ${directions[i]} == "$direction" ]] && { orientation=$i; break; }; done
    [[ -n $orientation ]] || { echo "invalid direction"; return 1; }
    for ((i=0; i<${#instructions}; i++)); do
        command=${instructions:i:1}
        case $command in
            R) orientation=$(((orientation+1)%4)) ;;
            L) orientation=$(((orientation+3)%4)) ;;
            A)
                case $orientation in
                    0) y=$((y+1)) ;;
                    1) x=$((x+1)) ;;
                    2) y=$((y-1)) ;;
                    3) x=$((x-1)) ;;
                esac
                ;;
            *) echo "invalid instruction: $command"; return 1 ;;
        esac
    done
    printf '%s %s %s\n' "$x" "$y" "${directions[orientation]}"
}

main "$@"
