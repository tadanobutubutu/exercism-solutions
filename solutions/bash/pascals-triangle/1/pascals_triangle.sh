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
    local rows=${1:-}
    [[ $rows =~ ^[0-9]+$ ]] || return 1
    rows=$((10#$rows))
    local -a previous=(1) current=()
    local row col leading line
    for ((row=1; row<=rows; row++)); do
        leading=$((rows-row))
        line=$(printf '%*s' "$leading" '')
        current=()
        if ((row == 1)); then current=(1)
        else
            current+=(1)
            for ((col=1; col<row-1; col++)); do current+=("$((previous[col-1] + previous[col]))"); done
            current+=(1)
        fi
        local IFS=' '
        printf '%s%s\n' "$line" "${current[*]}"
        previous=("${current[@]}")
    done
}

main "$@"
