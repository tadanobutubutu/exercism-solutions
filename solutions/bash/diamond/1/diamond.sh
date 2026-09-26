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
    local letter=${1:-}
    [[ $letter =~ ^[A-Z]$ ]] || return 1
    local alphabet=ABCDEFGHIJKLMNOPQRSTUVWXYZ index=0 i row letter_index leading inner line
    for ((i=0; i<26; i++)); do [[ ${alphabet:i:1} == "$letter" ]] && { index=$i; break; }; done
    for ((row=0; row<=2*index; row++)); do
        if ((row <= index)); then letter_index=$row; else letter_index=$((2*index-row)); fi
        leading=$((index-letter_index))
        line=$(printf '%*s' "$leading" '')
        line+="${alphabet:letter_index:1}"
        if ((letter_index > 0)); then
            inner=$((2*letter_index-1))
            line+=$(printf '%*s' "$inner" '')
            line+="${alphabet:letter_index:1}"
        fi
        line+=$(printf '%*s' "$leading" '')
        printf '%s\n' "$line"
    done
}

main "$@"
