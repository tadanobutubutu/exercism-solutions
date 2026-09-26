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
    (($# == 3)) || { echo "invalid arguments" >&2; return 1; }
    local input_base=$1 digits=$2 output_base=$3 digit value=0 remainder
    [[ $input_base =~ ^[0-9]+$ && $output_base =~ ^[0-9]+$ ]] || { echo "invalid base" >&2; return 1; }
    input_base=$((10#$input_base)); output_base=$((10#$output_base))
    ((input_base >= 2 && output_base >= 2)) || { echo "base must be at least two" >&2; return 1; }
    local -a parts=() result=()
    if [[ -n $digits ]]; then read -r -a parts <<< "$digits"; fi
    for digit in "${parts[@]}"; do
        [[ $digit =~ ^[0-9]+$ ]] || { echo "invalid digit" >&2; return 1; }
        digit=$((10#$digit))
        ((digit < input_base)) || { echo "digit out of range" >&2; return 1; }
        value=$((value * input_base + digit))
    done
    if ((value == 0)); then echo 0; return 0; fi
    while ((value > 0)); do
        remainder=$((value % output_base))
        result=("$remainder" "${result[@]}")
        value=$((value / output_base))
    done
    local IFS=' '
    echo "${result[*]}"
}

main "$@"
