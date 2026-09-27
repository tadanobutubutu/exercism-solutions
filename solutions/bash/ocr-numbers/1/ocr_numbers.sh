#!/usr/bin/env bash

lines=()
while IFS= read -r line || [[ -n $line ]]; do lines+=("$line"); done
line_count=${#lines[@]}
((line_count == 0)) && exit 0
if ((line_count % 4 != 0)); then
    echo "Number of input lines is not a multiple of four"
    exit 1
fi
width=${#lines[0]}
if ((width % 3 != 0)); then
    echo "Number of input columns is not a multiple of three"
    exit 1
fi
for line in "${lines[@]}"; do
    if ((${#line} != width || ${#line} % 3 != 0)); then
        echo "Number of input columns is not a multiple of three"
        exit 1
    fi
done

output=''
for ((base=0; base<line_count; base+=4)); do
    ((base == 0)) || output+=','
    for ((column=0; column<width; column+=3)); do
        r0=${lines[base]:column:3}
        r1=${lines[base+1]:column:3}
        r2=${lines[base+2]:column:3}
        r3=${lines[base+3]:column:3}
        pattern="$r0/$r1/$r2/$r3"
        case $pattern in
            ' _ /| |/|_|/   ') digit=0 ;;
            '   /  |/  |/   ') digit=1 ;;
            ' _ / _|/|_ /   ') digit=2 ;;
            ' _ / _|/ _|/   ') digit=3 ;;
            '   /|_|/  |/   ') digit=4 ;;
            ' _ /|_ / _|/   ') digit=5 ;;
            ' _ /|_ /|_|/   ') digit=6 ;;
            ' _ /  |/  |/   ') digit=7 ;;
            ' _ /|_|/|_|/   ') digit=8 ;;
            ' _ /|_|/ _|/   ') digit=9 ;;
            *) digit='?' ;;
        esac
        output+=$digit
    done
done
printf '%s\n' "$output"
