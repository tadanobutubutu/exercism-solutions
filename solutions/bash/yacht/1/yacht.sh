#!/usr/bin/env bash

category=${1:-}
shift || true
dice=("$@")
counts=(0 0 0 0 0 0 0)
total=0
for die in "${dice[@]}"; do
    [[ $die =~ ^[1-6]$ ]] || exit 1
    counts[die]=$((counts[die]+1))
    total=$((total+die))
done
((${#dice[@]} == 5)) || exit 1

score=0
case $category in
    ones|twos|threes|fours|fives|sixes)
        case $category in
            ones) face=1 ;; twos) face=2 ;; threes) face=3 ;;
            fours) face=4 ;; fives) face=5 ;; sixes) face=6 ;;
        esac
        score=$((face*counts[face]))
        ;;
    full\ house)
        has_two=0; has_three=0
        for ((face=1; face<=6; face++)); do
            ((counts[face] == 2)) && has_two=1
            ((counts[face] == 3)) && has_three=1
        done
        ((has_two && has_three)) && score=$total
        ;;
    four\ of\ a\ kind)
        for ((face=1; face<=6; face++)); do
            if ((counts[face] >= 4)); then score=$((face*4)); break; fi
        done
        ;;
    little\ straight)
        straight=1
        for ((face=1; face<=5; face++)); do ((counts[face] == 1)) || straight=0; done
        ((counts[6] == 0)) || straight=0
        ((straight)) && score=30
        ;;
    big\ straight)
        straight=1
        ((counts[1] == 0)) || straight=0
        for ((face=2; face<=6; face++)); do ((counts[face] == 1)) || straight=0; done
        ((straight)) && score=30
        ;;
    choice) score=$total ;;
    yacht)
        for ((face=1; face<=6; face++)); do
            if ((counts[face] == 5)); then score=50; break; fi
        done
        ;;
    *) exit 1 ;;
esac
echo "$score"
