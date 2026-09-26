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

normalized() {
    printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | fold -w1 | LC_ALL=C sort | tr -d '\n'
}

main() {
    local subject=${1:-} candidates=${2:-} candidate lowered_subject key
    lowered_subject=$(printf '%s' "$subject" | tr '[:upper:]' '[:lower:]')
    key=$(normalized "$subject")
    local -a matches=()
    for candidate in $candidates; do
        local lowered_candidate
        lowered_candidate=$(printf '%s' "$candidate" | tr '[:upper:]' '[:lower:]')
        [[ $lowered_candidate == "$lowered_subject" ]] && continue
        [[ $(normalized "$candidate") == "$key" ]] && matches+=("$candidate")
    done
    local IFS=' '
    echo "${matches[*]}"
}

main "$@"
