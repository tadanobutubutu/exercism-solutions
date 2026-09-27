#!/usr/bin/env bash

invalid() { echo "$1"; exit 1; }
local_rolls=()
for value in "$@"; do
    [[ $value =~ ^-?[0-9]+$ ]] || invalid "Pin count exceeds pins on the lane"
    ((value >= 0)) || invalid "Negative roll is invalid"
    ((value <= 10)) || invalid "Pin count exceeds pins on the lane"
    local_rolls+=("$((10#$value))")
done

count=${#local_rolls[@]}
index=0
for ((frame=1; frame<=9; frame++)); do
    ((index < count)) || invalid "Score cannot be taken until the end of the game"
    first=${local_rolls[index]}
    if ((first == 10)); then
        ((index += 1))
    else
        ((index+1 < count)) || invalid "Score cannot be taken until the end of the game"
        second=${local_rolls[index+1]}
        ((first+second <= 10)) || invalid "Pin count exceeds pins on the lane"
        ((index += 2))
    fi
done

((index < count)) || invalid "Score cannot be taken until the end of the game"
last_first=${local_rolls[index]}
if ((last_first == 10)); then
    ((index+2 < count)) || invalid "Score cannot be taken until the end of the game"
    last_second=${local_rolls[index+1]}
    last_third=${local_rolls[index+2]}
    if ((last_second < 10 && last_second+last_third > 10)); then
        invalid "Pin count exceeds pins on the lane"
    fi
    index=$((index+3))
else
    ((index+1 < count)) || invalid "Score cannot be taken until the end of the game"
    last_second=${local_rolls[index+1]}
    ((last_first+last_second <= 10)) || invalid "Pin count exceeds pins on the lane"
    if ((last_first+last_second == 10)); then
        ((index+2 < count)) || invalid "Score cannot be taken until the end of the game"
        index=$((index+3))
    else
        index=$((index+2))
    fi
fi
((index == count)) || invalid "Cannot roll after game is over"

score=0
index=0
for ((frame=1; frame<=9; frame++)); do
    first=${local_rolls[index]}
    if ((first == 10)); then
        score=$((score+10+local_rolls[index+1]+local_rolls[index+2]))
        ((index += 1))
    else
        second=${local_rolls[index+1]}
        if ((first+second == 10)); then
            score=$((score+10+local_rolls[index+2]))
        else
            score=$((score+first+second))
        fi
        ((index += 2))
    fi
done
for ((; index<count; index++)); do score=$((score+local_rolls[index])); done
echo "$score"
