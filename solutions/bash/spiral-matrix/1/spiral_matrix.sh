#!/usr/bin/env bash

size=${1:-0}
[[ $size =~ ^[0-9]+$ ]] || exit 1
size=$((10#$size))
((size > 0)) || exit 0
matrix=()
for ((i=0; i<size*size; i++)); do matrix[i]=0; done
top=0; bottom=$((size-1)); left=0; right=$((size-1)); value=1
while ((top <= bottom && left <= right)); do
    for ((column=left; column<=right; column++)); do
        index=$((top*size+column)); matrix[index]=$value; ((value+=1))
    done
    ((top+=1))
    for ((row=top; row<=bottom; row++)); do
        index=$((row*size+right)); matrix[index]=$value; ((value+=1))
    done
    ((right-=1))
    if ((top <= bottom)); then
        for ((column=right; column>=left; column--)); do
            index=$((bottom*size+column)); matrix[index]=$value; ((value+=1))
        done
        ((bottom-=1))
    fi
    if ((left <= right)); then
        for ((row=bottom; row>=top; row--)); do
            index=$((row*size+left)); matrix[index]=$value; ((value+=1))
        done
        ((left+=1))
    fi
done
for ((row=0; row<size; row++)); do
    output=''
    for ((column=0; column<size; column++)); do
        ((column == 0)) || output+=' '
        output+=${matrix[row*size+column]}
    done
    printf '%s\n' "$output"
done
