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
    [[ $# == 2 ]] || { echo "2 arguments expected"; return 1; }
    [[ $1 =~ ^[0-9]+$ && $2 =~ ^[0-9]+$ ]] || { echo "invalid arguments"; return 1; }
    local bottles=$((10#$1)) verses=$((10#$2))
    ((bottles >= 1 && bottles <= 10 && verses >= 1)) || { echo "invalid arguments"; return 1; }
    ((verses <= bottles)) || { echo "cannot generate more verses than bottles"; return 1; }
    local -a words=(no one two three four five six seven eight nine ten)
    local -a capital=(No One Two Three Four Five Six Seven Eight Nine Ten)
    local current remaining start end output=""
    for ((current=bottles; current>bottles-verses; current--)); do
        remaining=$((current - 1))
        if ((current == 1)); then start="One green bottle"; else start="${capital[current]} green bottles"; fi
        if ((remaining == 0)); then end="no green bottles"
        elif ((remaining == 1)); then end="one green bottle"
        else end="${words[remaining]} green bottles"
        fi
        output+="$start hanging on the wall,\n$start hanging on the wall,\nAnd if one green bottle should accidentally fall,\nThere'll be $end hanging on the wall."
        ((current > bottles-verses+1)) && output+="\n\n"
    done
    printf '%b\n' "$output"
}

main "$@"
