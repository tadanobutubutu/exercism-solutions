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
    local -a garden=("$@")
    local height=${#garden[@]} row column width nr nc dr dc count cell output
    for ((row=0; row<height; row++)); do
        width=${#garden[row]}
        output=''
        for ((column=0; column<width; column++)); do
            cell=${garden[row]:column:1}
            if [[ $cell == '*' ]]; then output+='*'; continue; fi
            count=0
            for ((dr=-1; dr<=1; dr++)); do
                for ((dc=-1; dc<=1; dc++)); do
                    ((dr == 0 && dc == 0)) && continue
                    nr=$((row+dr)); nc=$((column+dc))
                    ((nr < 0 || nr >= height)) && continue
                    ((nc < 0)) && continue
                    ((nc >= ${#garden[nr]})) && continue
                    [[ ${garden[nr]:nc:1} == '*' ]] && count=$((count+1))
                done
            done
            if ((count == 0)); then output+=' '; else output+=$count; fi
        done
        printf '%s\n' "$output"
    done
}

main "$@"
