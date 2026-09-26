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

verse() {
    local number=$1 animal
    local -a animals=("" fly spider bird cat dog goat cow horse)
    local -a descriptions=("" "" "It wriggled and jiggled and tickled inside her." "How absurd to swallow a bird!" "Imagine that, to swallow a cat!" "What a hog, to swallow a dog!" "Just opened her throat and swallowed a goat!" "I don't know how she swallowed a cow!" "She's dead, of course!")
    animal=${animals[number]}
    if ((number == 8)); then printf 'I know an old lady who swallowed a horse.\n%s' "${descriptions[number]}"; return; fi
    printf 'I know an old lady who swallowed a %s.\n' "$animal"
    [[ -n ${descriptions[number]} ]] && printf '%s\n' "${descriptions[number]}"
    local i previous
    for ((i=number; i>=2; i--)); do
        previous=${animals[i-1]}
        if ((i-1 == 2)); then
            printf 'She swallowed the %s to catch the spider that wriggled and jiggled and tickled inside her.\n' "${animals[i]}"
        else
            printf 'She swallowed the %s to catch the %s.\n' "${animals[i]}" "$previous"
        fi
    done
    printf "I don't know why she swallowed the fly. Perhaps she'll die."
}

main() {
    (($# == 2)) || { echo "2 arguments expected"; return 1; }
    [[ $1 =~ ^[0-9]+$ && $2 =~ ^[0-9]+$ ]] || return 1
    local start=$((10#$1)) end=$((10#$2)) i
    ((start >= 1 && end <= 8)) || return 1
    ((start <= end)) || { echo "Start must be less than or equal to End"; return 1; }
    for ((i=start; i<=end; i++)); do
        ((i > start)) && printf '\n\n'
        verse "$i"
    done
    printf '\n'
}

main "$@"
