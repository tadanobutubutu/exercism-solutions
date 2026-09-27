#!/usr/bin/env bash

rows=()
while IFS= read -r line || [[ -n $line ]]; do rows+=("$line"); done
height=${#rows[@]}
((height > 1)) || { echo 0; exit 0; }
width=${#rows[0]}
count=0
for ((top=0; top<height-1; top++)); do
    for ((bottom=top+1; bottom<height; bottom++)); do
        for ((left=0; left<width-1; left++)); do
            [[ ${rows[top]:left:1} == + && ${rows[bottom]:left:1} == + ]] || continue
            for ((right=left+1; right<width; right++)); do
                [[ ${rows[top]:right:1} == + && ${rows[bottom]:right:1} == + ]] || continue
                horizontal_valid=1
                for ((column=left+1; column<right; column++)); do
                    top_cell=${rows[top]:column:1}
                    bottom_cell=${rows[bottom]:column:1}
                    if [[ $top_cell != + && $top_cell != - ]] || [[ $bottom_cell != + && $bottom_cell != - ]]; then
                        horizontal_valid=0
                        break
                    fi
                done
                ((horizontal_valid)) || continue
                vertical_valid=1
                for ((row=top+1; row<bottom; row++)); do
                    left_cell=${rows[row]:left:1}
                    right_cell=${rows[row]:right:1}
                    if [[ $left_cell != + && $left_cell != '|' ]] || [[ $right_cell != + && $right_cell != '|' ]]; then
                        vertical_valid=0
                        break
                    fi
                done
                ((vertical_valid)) && ((count+=1))
            done
        done
    done
done
echo "$count"
