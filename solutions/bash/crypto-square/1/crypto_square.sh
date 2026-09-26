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
    local text=${1:-} normalized length rows cols col row pos segment output=''
    normalized=$(printf '%s' "$text" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]')
    length=${#normalized}
    ((length == 0)) && { echo; return 0; }
    rows=1
    while ((rows * rows <= length)); do rows=$((rows+1)); done
    rows=$((rows-1))
    cols=$(((length + rows - 1) / rows))
    if ((cols - rows > 1)); then rows=$((rows+1)); cols=$(((length + rows - 1) / rows)); fi
    for ((col=0; col<cols; col++)); do
        segment=''
        for ((row=0; row<rows; row++)); do
            pos=$((row * cols + col))
            if ((pos < length)); then segment+=${normalized:pos:1}; else segment+=' '; fi
        done
        output+="$segment"
        ((col < cols-1)) && output+=' '
    done
    printf '%s\n' "$output"
}

main "$@"
