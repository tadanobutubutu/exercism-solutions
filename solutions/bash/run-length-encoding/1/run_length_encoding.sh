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
    local mode=${1:-} text=${2:-} output='' current next count digit i
    case $mode in
        encode)
            for ((i=0; i<${#text};)); do
                current=${text:i:1}; count=1
                while ((i+count < ${#text})) && [[ ${text:i+count:1} == "$current" ]]; do count=$((count+1)); done
                ((count > 1)) && output+=$count
                output+=$current
                i=$((i+count))
            done
            ;;
        decode)
            count=''
            for ((i=0; i<${#text}; i++)); do
                current=${text:i:1}
                if [[ $current =~ ^[0-9]$ ]]; then count+=$current
                else
                    [[ -n $count ]] || count=1
                    for ((digit=0; digit<count; digit++)); do output+=$current; done
                    count=''
                fi
            done
            ;;
        *) echo "invalid mode" >&2; return 1 ;;
    esac
    printf '%s\n' "$output"
}

main "$@"
