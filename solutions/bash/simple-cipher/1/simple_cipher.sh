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
    local key='' mode text option char key_char index shift output='' i alphabet=abcdefghijklmnopqrstuvwxyz
    if [[ ${1:-} == key ]]; then
        for ((i=0; i<120; i++)); do index=$((RANDOM%26)); output+=${alphabet:index:1}; done
        printf '%s\n' "$output"
        return 0
    fi
    (($# >= 3)) || { echo "invalid arguments"; return 1; }
    if [[ $1 == -k ]]; then key=$2; shift 2; mode=${1:-}; text=${2:-}
    else mode=$1; text=${2:-}
    fi
    [[ $mode == encode || $mode == decode ]] || { echo "invalid mode"; return 1; }
    [[ -n $key && $key =~ ^[a-z]+$ ]] || { echo "invalid key"; return 1; }
    text=$(printf '%s' "$text" | tr '[:upper:]' '[:lower:]')
    for ((i=0; i<${#text}; i++)); do
        char=${text:i:1}
        [[ $char =~ ^[a-z]$ ]] || { echo "invalid text"; return 1; }
        key_char=${key:i%${#key}:1}
        index=0; shift=0
        for ((option=0; option<26; option++)); do
            [[ ${alphabet:option:1} == "$char" ]] && index=$option
            [[ ${alphabet:option:1} == "$key_char" ]] && shift=$option
        done
        if [[ $mode == encode ]]; then index=$(((index+shift)%26)); else index=$(((index-shift+26)%26)); fi
        output+=${alphabet:index:1}
    done
    printf '%s\n' "$output"
}

main "$@"
