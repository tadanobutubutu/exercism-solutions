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

gcd() {
    local a=$1 b=$2 t
    ((a < 0)) && a=$((-a))
    ((b < 0)) && b=$((-b))
    while ((b != 0)); do t=$((a%b)); a=$b; b=$t; done
    echo "$a"
}

normalize() {
    local n=$1 d=$2 divisor
    ((d != 0)) || return 1
    if ((d < 0)); then n=$((-n)); d=$((-d)); fi
    divisor=$(gcd "$n" "$d")
    ((divisor == 0)) && divisor=1
    result="$((n/divisor))/$((d/divisor))"
}

parse_fraction() {
    local fraction=$1
    [[ $fraction == */* ]] || return 1
    parsed_n=${fraction%%/*}; parsed_d=${fraction#*/}
    [[ $parsed_n =~ ^-?[0-9]+$ && $parsed_d =~ ^-?[0-9]+$ ]] || return 1
}

format_real() {
    local formatted
    formatted=$(awk -v value="$1" 'BEGIN { printf "%.6f", value }')
    while [[ $formatted == *0 ]]; do formatted=${formatted%0}; done
    [[ $formatted == *. ]] && formatted+=0
    result=$formatted
}

main() {
    local operation=${1:-} first=${2:-} second=${3:-} exponent n1 d1 n2 d2 n d i
    if [[ $operation == rpow ]]; then
        [[ $first =~ ^-?[0-9]+([.][0-9]+)?$ ]] || { echo "invalid real number" >&2; return 1; }
    else
        parse_fraction "$first" || { echo "invalid rational number" >&2; return 1; }
        n1=$parsed_n; d1=$parsed_d
    fi
    case $operation in
        abs)
            ((n1 < 0)) && n1=$((-n1))
            ((d1 < 0)) && d1=$((-d1))
            normalize "$n1" "$d1" || return 1
            ;;
        reduce)
            normalize "$n1" "$d1" || return 1
            ;;
        pow)
            if [[ $second =~ ^-?[0-9]+\.[0-9]+$ ]]; then
                format_real "$(awk -v n="$n1" -v d="$d1" -v x="$second" 'BEGIN { print (n/d)^x }')"
                echo "$result"
                return 0
            fi
            [[ $second =~ ^-?[0-9]+$ ]] || return 1
            exponent=$second
            if ((exponent < 0)); then
                ((n1 != 0)) || return 1
                n=$d1; d=$n1; exponent=$((-exponent))
                n1=$n; d1=$d
            fi
            n=1; d=1
            for ((i=0; i<exponent; i++)); do n=$((n*n1)); d=$((d*d1)); done
            normalize "$n" "$d" || return 1
            ;;
        rpow)
            parse_fraction "$second" || { echo "invalid rational number" >&2; return 1; }
            n2=$parsed_n; d2=$parsed_d
            ((d2 != 0)) || return 1
            format_real "$(awk -v x="$first" -v n="$n2" -v d="$d2" 'BEGIN { print x^(n/d) }')"
            ;;
        +|-|\*|/)
            parse_fraction "$second" || { echo "invalid rational number" >&2; return 1; }
            n2=$parsed_n; d2=$parsed_d
            case $operation in
                +) n=$((n1*d2+n2*d1)); d=$((d1*d2)) ;;
                -) n=$((n1*d2-n2*d1)); d=$((d1*d2)) ;;
                '*') n=$((n1*n2)); d=$((d1*d2)) ;;
                /) ((n2 != 0)) || return 1; n=$((n1*d2)); d=$((d1*n2)) ;;
            esac
            normalize "$n" "$d" || return 1
            ;;
        *) echo "invalid operation" >&2; return 1 ;;
    esac
    echo "$result"
}

main "$@"
