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

modular_power() {
    local base=$1 exponent=$2 modulus=$3 result=1
    base=$((base % modulus))
    while ((exponent > 0)); do
        ((exponent & 1)) && result=$((result * base % modulus))
        base=$((base * base % modulus))
        exponent=$((exponent / 2))
    done
    echo "$result"
}

main() {
    local operation=${1:-} p=${2:-} g=${3:-} private=${4:-}
    case $operation in
        privateKey)
            [[ $p =~ ^[0-9]+$ ]] && ((p > 2)) || return 1
            echo $((RANDOM % (p - 2) + 2))
            ;;
        publicKey)
            [[ $p =~ ^[0-9]+$ && $g =~ ^[0-9]+$ && $private =~ ^[0-9]+$ ]] || return 1
            echo "$(modular_power "$g" "$private" "$p")"
            ;;
        secret)
            [[ $p =~ ^[0-9]+$ && $g =~ ^[0-9]+$ && $private =~ ^[0-9]+$ ]] || return 1
            echo "$(modular_power "$g" "$private" "$p")"
            ;;
        *) return 1 ;;
    esac
}

main "$@"
