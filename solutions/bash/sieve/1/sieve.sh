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
    local limit=${1:-}
    [[ $limit =~ ^-?[0-9]+$ ]] || return 1
    [[ $limit != -* ]] || { echo; return 0; }
    limit=$((10#$limit))
    local -a prime=()
    local i multiple
    for ((i=2; i<=limit; i++)); do prime[i]=1; done
    for ((i=2; i*i<=limit; i++)); do
        if ((prime[i])); then
            for ((multiple=i*i; multiple<=limit; multiple+=i)); do prime[multiple]=0; done
        fi
    done
    local -a result=()
    for ((i=2; i<=limit; i++)); do ((prime[i])) && result+=("$i"); done
    local IFS=' '
    echo "${result[*]}"
}

main "$@"
