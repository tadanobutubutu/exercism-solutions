#!/usr/bin/env bash

size_one=${1:-}
size_two=${2:-}
goal=${3:-}
start=${4:-}
if [[ ! $size_one =~ ^[0-9]+$ || ! $size_two =~ ^[0-9]+$ || ! $goal =~ ^[0-9]+$ ]] || [[ $start != one && $start != two ]]; then
    echo "invalid input"
    exit 1
fi
size_one=$((10#$size_one)); size_two=$((10#$size_two)); goal=$((10#$goal))
if ((size_one <= 0 || size_two <= 0 || (goal > size_one && goal > size_two))); then
    echo "invalid goal"
    exit 1
fi
if [[ $start == one ]]; then start_one=$size_one; start_two=0; else start_one=0; start_two=$size_two; fi

queue_one=("$start_one"); queue_two=("$start_two"); queue_moves=(1)
visited=()
start_key=$((start_one*(size_two+1)+start_two))
visited[start_key]=1
head=0
while ((head < ${#queue_one[@]})); do
    current_one=${queue_one[head]}
    current_two=${queue_two[head]}
    moves=${queue_moves[head]}
    if ((current_one == goal)); then
        echo "moves: $moves, goalBucket: one, otherBucket: $current_two"
        exit 0
    elif ((current_two == goal)); then
        echo "moves: $moves, goalBucket: two, otherBucket: $current_one"
        exit 0
    fi
    for ((action=1; action<=6; action++)); do
        next_one=$current_one; next_two=$current_two
        case $action in
            1) next_one=$size_one ;;
            2) next_two=$size_two ;;
            3) next_one=0 ;;
            4) next_two=0 ;;
            5)
                transfer=$current_one
                space=$((size_two-current_two))
                ((transfer > space)) && transfer=$space
                next_one=$((current_one-transfer)); next_two=$((current_two+transfer))
                ;;
            6)
                transfer=$current_two
                space=$((size_one-current_one))
                ((transfer > space)) && transfer=$space
                next_two=$((current_two-transfer)); next_one=$((current_one+transfer))
                ;;
        esac
        if [[ $start == one ]] && ((next_one == 0 && next_two == size_two)); then continue; fi
        if [[ $start == two ]] && ((next_two == 0 && next_one == size_one)); then continue; fi
        next_key=$((next_one*(size_two+1)+next_two))
        ((visited[next_key] == 1)) && continue
        visited[next_key]=1
        queue_one+=("$next_one"); queue_two+=("$next_two"); queue_moves+=("$((moves+1))")
    done
    ((head+=1))
done
echo "invalid goal"
exit 1
