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

under_1000() {
    local value=$1 hundreds remainder output=''
    local -a ones=(zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen)
    local -a tens=('' '' twenty thirty forty fifty sixty seventy eighty ninety)
    hundreds=$((value/100)); remainder=$((value%100))
    if ((hundreds)); then output="${ones[hundreds]} hundred"; fi
    if ((remainder)); then
        ((hundreds)) && output+=' '
        if ((remainder < 20)); then output+=${ones[remainder]}
        else
            output+=${tens[remainder/10]}
            ((remainder%10)) && output+="-${ones[remainder%10]}"
        fi
    fi
    printf '%s' "$output"
}

main() {
    local number=${1:-} group scale output='' remainder
    [[ $number =~ ^[0-9]+$ ]] || { echo "input out of range"; return 1; }
    number=$((10#$number))
    ((number <= 999999999999)) || { echo "input out of range"; return 1; }
    ((number == 0)) && { echo zero; return 0; }
    local -a values=(1000000000 1000000 1000 1) names=(billion million thousand '')
    for group in "${!values[@]}"; do
        scale=${values[group]}
        remainder=$((number/scale))
        if ((remainder > 0)); then
            [[ -n $output ]] && output+=' '
            output+="$(under_1000 "$remainder")"
            [[ -n ${names[group]} ]] && output+=" ${names[group]}"
            number=$((number%scale))
        fi
    done
    echo "$output"
}

main "$@"
