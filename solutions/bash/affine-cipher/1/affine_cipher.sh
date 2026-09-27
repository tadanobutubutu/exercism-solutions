#!/usr/bin/env bash

mode=${1:-}
a=${2:-0}
b=${3:-0}
input=${4:-}
alphabet=abcdefghijklmnopqrstuvwxyz

gcd() {
    local x=$1 y=$2 temp
    while ((y != 0)); do temp=$((x % y)); x=$y; y=$temp; done
    echo "$x"
}

if [[ ! $a =~ ^-?[0-9]+$ || ! $b =~ ^-?[0-9]+$ ]]; then
    echo "invalid key"
    exit 1
fi
a=$(( (a % 26 + 26) % 26 ))
b=$(( (b % 26 + 26) % 26 ))
if (( $(gcd "$a" 26) != 1 )); then
    echo "a and m must be coprime."
    exit 1
fi

inverse=0
for ((i=1; i<26; i++)); do
    if (((a*i)%26 == 1)); then inverse=$i; break; fi
done
input=$(printf '%s' "$input" | tr '[:upper:]' '[:lower:]')
plain_or_cipher=''
for ((i=0; i<${#input}; i++)); do
    char=${input:i:1}
    case $char in
        [a-z])
            prefix=${alphabet%%"$char"*}
            x=${#prefix}
            if [[ $mode == encode ]]; then
                y=$(( (a*x+b)%26 ))
            else
                y=$(( (inverse*(x-b+26))%26 ))
            fi
            plain_or_cipher+=${alphabet:y:1}
            ;;
        [0-9]) plain_or_cipher+=$char ;;
    esac
done

if [[ $mode == encode ]]; then
    output=''
    for ((i=0; i<${#plain_or_cipher}; i++)); do
        ((i > 0 && i % 5 == 0)) && output+=' '
        output+=${plain_or_cipher:i:1}
    done
else
    output=$plain_or_cipher
fi
printf '%s\n' "$output"
