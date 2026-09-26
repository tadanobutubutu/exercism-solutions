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
    local -a rows=()
    local line max_width=0 row column char output last_present
    while IFS= read -r line || [[ -n $line ]]; do
        rows+=("$line")
        ((${#line} > max_width)) && max_width=${#line}
    done
    for ((column=0; column<max_width; column++)); do
        output=''
        last_present=-1
        for ((row=0; row<${#rows[@]}; row++)); do
            ((column < ${#rows[row]})) && last_present=$row
        done
        ((last_present >= 0)) || continue
        for ((row=0; row<=last_present; row++)); do
            if ((column < ${#rows[row]})); then char=${rows[row]:column:1}; else char=' '; fi
            output+=$char
        done
        printf '%s\n' "$output"
    done
}

main "$@"
