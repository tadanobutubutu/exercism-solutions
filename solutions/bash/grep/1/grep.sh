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
    local show_numbers=0 list_files=0 ignore_case=0 invert=0 whole_line=0 arg pattern file line line_number matched file_matched prefix
    while (($#)) && [[ $1 == -* ]]; do
        arg=$1; shift
        case $arg in
            -n) show_numbers=1 ;;
            -l) list_files=1 ;;
            -i) ignore_case=1 ;;
            -v) invert=1 ;;
            -x) whole_line=1 ;;
            *) echo "invalid flag: $arg" >&2; return 1 ;;
        esac
    done
    (($# >= 2)) || { echo "pattern and files required" >&2; return 1; }
    pattern=$1; shift
    local file_count=$#
    local -a output_lines=() matched_files=()
    ((ignore_case)) && shopt -s nocasematch
    for file in "$@"; do
        line_number=0; file_matched=0
        while IFS= read -r line || [[ -n $line ]]; do
            line_number=$((line_number+1))
            if ((whole_line)); then [[ $line == "$pattern" ]] && matched=1 || matched=0
            else [[ $line == *"$pattern"* ]] && matched=1 || matched=0
            fi
            ((invert)) && matched=$((1-matched))
            if ((matched)); then
                file_matched=1
                if ((!list_files)); then
                    prefix=''
                    ((file_count > 1)) && prefix="$file:"
                    ((show_numbers)) && prefix+="$line_number:"
                    output_lines+=("$prefix$line")
                fi
            fi
        done < "$file"
        ((list_files && file_matched)) && matched_files+=("$file")
    done
    if ((list_files)); then
        ((${#matched_files[@]})) && printf '%s\n' "${matched_files[@]}"
    elif ((${#output_lines[@]})); then
        printf '%s\n' "${output_lines[@]}"
    fi
    return 0
}

main "$@"
