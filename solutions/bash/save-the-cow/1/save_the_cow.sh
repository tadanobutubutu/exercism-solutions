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
    (($# >= 1)) || { echo "word is required" >&2; return 1; }
    local word=$1 masked='' remaining=9 state=Ongoing guess char found repeated i
    shift
    for ((i=0; i<${#word}; i++)); do masked+='_'; done
    local -a guesses=()
    for guess in "$@"; do
        [[ -n $guess ]] || continue
        [[ $state == Win ]] && { echo "cannot guess after the game is won"; return 1; }
        [[ $state == Lose ]] && { echo "cannot guess after the game is lost"; return 1; }
        repeated=0
        for char in "${guesses[@]}"; do [[ $char == "$guess" ]] && { repeated=1; break; }; done
        if ((repeated)); then
            if ((remaining == 0)); then state=Lose; else remaining=$((remaining-1)); fi
        else
            guesses+=("$guess")
            found=0
            for ((i=0; i<${#word}; i++)); do
                if [[ ${word:i:1} == "$guess" ]]; then masked="${masked:0:i}${guess}${masked:i+1}"; found=1; fi
            done
            if ((!found)); then
                if ((remaining == 0)); then state=Lose; else remaining=$((remaining-1)); fi
            fi
        fi
        [[ $masked == "$word" ]] && state=Win
    done
    printf 'State: %s\nMasked word: %s\nRemaining failures: %s\n' "$state" "$masked" "$remaining"
}

main "$@"
