#!/usr/bin/env bash

die() { echo "$*" >&2; exit 1; }

encode() {
    local hex value byte encoded index output=''
    local -a bytes=()
    for hex in "$@"; do
        printf -v value '%d' "0x$hex" || die "invalid hexadecimal value"
        bytes=()
        while :; do
            byte=$((value & 127))
            value=$((value >> 7))
            bytes+=("$byte")
            ((value == 0)) && break
        done
        for ((index=${#bytes[@]}-1; index>=0; index--)); do
            byte=${bytes[index]}
            ((index > 0)) && byte=$((byte | 128))
            printf -v encoded '%02X' "$byte"
            [[ -z $output ]] || output+=' '
            output+=$encoded
        done
    done
    echo "$output"
}

decode() {
    local hex value accumulator=0 output='' decoded last_hex=''
    local -a values=()
    for hex in "$@"; do last_hex=$hex; done
    if [[ -n $last_hex ]]; then
        printf -v value '%d' "0x$last_hex" || die "invalid hexadecimal byte"
        ((value & 128)) && die "incomplete byte sequence"
    fi
    for hex in "$@"; do
        printf -v value '%d' "0x$hex" || die "invalid hexadecimal byte"
        accumulator=$(((accumulator << 7) | (value & 127)))
        if (( (value & 128) == 0 )); then
            printf -v decoded '%02X' "$accumulator"
            values+=("$decoded")
            accumulator=0
        fi
    done
    echo "${values[*]}"
}

command=${1:-}
shift || true
case $command in
    encode|decode) "$command" "$@" ;;
    *) die "unknown subcommand" ;;
esac
