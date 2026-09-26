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

modifier() {
    local score=$1
    if ((score >= 10)); then echo $(((score - 10) / 2)); else echo $(( -((11 - score) / 2) )); fi
}

roll_ability() {
    local i die sum=0 smallest=7
    for ((i=0; i<4; i++)); do
        die=$((RANDOM % 6 + 1))
        sum=$((sum + die))
        ((die < smallest)) && smallest=$die
    done
    echo $((sum - smallest))
}

main() {
    if [[ ${1:-} == modifier && ${2:-} =~ ^[0-9]+$ ]]; then
        modifier "$2"
    elif [[ ${1:-} == generate ]]; then
        local name score constitution=0
        for name in strength dexterity constitution intelligence wisdom charisma; do
            score=$(roll_ability)
            [[ $name == constitution ]] && constitution=$score
            printf '%s %s\n' "$name" "$score"
        done
        printf 'hitpoints %s\n' "$((10 + $(modifier "$constitution")))"
    else
        echo "invalid arguments" >&2
        return 1
    fi
}

main "$@"
