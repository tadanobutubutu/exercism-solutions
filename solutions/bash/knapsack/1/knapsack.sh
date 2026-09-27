#!/usr/bin/env bash

maximum_weight=${1:-}
[[ $maximum_weight =~ ^[0-9]+$ ]] || exit 1
maximum_weight=$((10#$maximum_weight))
shift
items=("$@")
values=()
for ((weight=0; weight<=maximum_weight; weight++)); do values[weight]=0; done
for item in "${items[@]}"; do
    [[ $item =~ ^([0-9]+):([0-9]+)$ ]] || exit 1
    weight=${BASH_REMATCH[1]}
    value=${BASH_REMATCH[2]}
    for ((capacity=maximum_weight; capacity>=weight; capacity--)); do
        candidate=$((values[capacity-weight]+value))
        ((candidate > values[capacity])) && values[capacity]=$candidate
    done
done
echo "${values[maximum_weight]}"
