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
    local first=${1:-} last=${2:-}
    if [[ ! $first =~ ^[0-9]+$ || ! $last =~ ^[0-9]+$ ]] || ((10#$first < 1 || 10#$last > 12 || 10#$first > 10#$last)); then
        echo "invalid verse range"
        return 1
    fi
    local -a subjects=("" "malt" "rat" "cat" "dog" "cow with the crumpled horn" "maiden all forlorn" "man all tattered and torn" "priest all shaven and shorn" "rooster that crowed in the morn" "farmer sowing his corn" "horse and the hound and the horn")
    local -a actions=("" "lay in" "ate" "killed" "worried" "tossed" "milked" "kissed" "married" "woke" "kept" "belonged to")
    local verse j line
    for ((verse=10#$first; verse<=10#$last; verse++)); do
        line="the house that Jack built."
        for ((j=2; j<=verse; j++)); do
            line="the ${subjects[j-1]} that ${actions[j-1]} $line"
        done
        printf 'This is %s\n' "$line"
    done
}

main "$@"
