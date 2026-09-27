#!/usr/bin/env bash

mode=${1:-}
rails_text=${2:-}
text=${3:-}
if [[ $mode != -e && $mode != -d ]] || [[ ! $rails_text =~ ^[0-9]+$ ]]; then
    echo "usage: rail_fence_cipher.sh -e|-d rails text"
    exit 1
fi
rails=$((10#$rails_text))
if ((rails < 1)); then echo "rails must be positive"; exit 1; fi
length=${#text}
if [[ $mode == -e ]]; then
    rows=()
    for ((row=0; row<rails; row++)); do rows[row]=''; done
    rail=0; direction=1
    for ((index=0; index<length; index++)); do
        rows[rail]+=${text:index:1}
        if ((rails > 1)); then
            if ((rail == 0)); then direction=1; elif ((rail == rails-1)); then direction=-1; fi
            rail=$((rail+direction))
        fi
    done
    output=''
    for ((row=0; row<rails; row++)); do output+=${rows[row]}; done
else
    path=(); counts=(); rows=(); positions=()
    for ((row=0; row<rails; row++)); do counts[row]=0; positions[row]=0; done
    rail=0; direction=1
    for ((index=0; index<length; index++)); do
        path[index]=$rail
        counts[rail]=$((counts[rail]+1))
        if ((rails > 1)); then
            if ((rail == 0)); then direction=1; elif ((rail == rails-1)); then direction=-1; fi
            rail=$((rail+direction))
        fi
    done
    offset=0
    for ((row=0; row<rails; row++)); do
        rows[row]=${text:offset:counts[row]}
        offset=$((offset+counts[row]))
    done
    output=''
    for ((index=0; index<length; index++)); do
        rail=${path[index]}
        output+=${rows[rail]:positions[rail]:1}
        positions[rail]=$((positions[rail]+1))
    done
fi
printf '%s\n' "$output"
