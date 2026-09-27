#!/usr/bin/env bash

rows=("$@")
height=${#rows[@]}
((height > 0)) || exit 0
width=${#rows[0]}
next=()
for ((r=0; r<height; r++)); do
    row=''
    for ((c=0; c<width; c++)); do
        neighbors=0
        for ((dr=-1; dr<=1; dr++)); do
            for ((dc=-1; dc<=1; dc++)); do
                ((dr == 0 && dc == 0)) && continue
                nr=$((r+dr)); nc=$((c+dc))
                if ((nr >= 0 && nr < height && nc >= 0)); then
                    row_width=${#rows[nr]}
                    if ((nc < row_width)) && [[ ${rows[nr]:nc:1} == 1 ]]; then ((neighbors+=1)); fi
                fi
            done
        done
        alive=${rows[r]:c:1}
        if [[ $alive == 1 ]]; then
            ((neighbors == 2 || neighbors == 3)) && row+=1 || row+=0
        else
            ((neighbors == 3)) && row+=1 || row+=0
        fi
    done
    next+=("$row")
done
printf '%s\n' "${next[@]}"
