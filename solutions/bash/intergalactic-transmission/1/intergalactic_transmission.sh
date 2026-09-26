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
    local mode=${1:-} message=${2:-} token hex value bit bits='' chunk ones parity encoded byte_bits output='' i
    local -a bytes=()
    [[ -n $message ]] && read -r -a bytes <<< "$message"
    case $mode in
        transmit_sequence)
            for token in "${bytes[@]}"; do
                [[ $token =~ ^0x[[:xdigit:]]{2}$ ]] || return 1
                hex=${token#0x}
                value=$((16#$hex))
                for ((bit=7; bit>=0; bit--)); do bits+=$(((value>>bit)&1)); done
            done
            for ((i=0; i<${#bits}; i+=7)); do
                chunk=${bits:i:7}
                while ((${#chunk}<7)); do chunk+=0; done
                ones=0
                for ((bit=0; bit<7; bit++)); do [[ ${chunk:bit:1} == 1 ]] && ones=$((ones+1)); done
                parity=$((ones%2))
                byte_bits="$chunk$parity"
                encoded=$((2#$byte_bits))
                printf -v token '0x%02x' "$encoded"
                [[ -n $output ]] && output+=' '
                output+=$token
            done
            printf '%s\n' "$output"
            ;;
        decode_message)
            for token in "${bytes[@]}"; do
                [[ $token =~ ^0x[[:xdigit:]]{2}$ ]] || return 1
                hex=${token#0x}; value=$((16#$hex)); byte_bits=''; ones=0
                for ((bit=7; bit>=0; bit--)); do
                    i=$(((value>>bit)&1)); byte_bits+=$i; ((i == 1)) && ones=$((ones+1))
                done
                if ((ones%2 != 0)); then echo "wrong parity"; return 0; fi
                bits+=${byte_bits:0:7}
            done
            local bit_length=$(((${#bits}/8)*8))
            bits=${bits:0:bit_length}
            for ((i=0; i<bit_length; i+=8)); do
                value=$((2#${bits:i:8}))
                printf -v token '0x%02x' "$value"
                [[ -n $output ]] && output+=' '
                output+=$token
            done
            printf '%s\n' "$output"
            ;;
        *) echo "invalid operation" >&2; return 1 ;;
    esac
}

main "$@"
