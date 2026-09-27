#!/usr/bin/env bash

target=${1:-}
[[ $target =~ ^-?[0-9]+$ ]] || exit 1
if ((target < 0)); then echo "target can't be negative"; exit 1; fi
shift
coins=("$@")
for coin in "${coins[@]}"; do
    [[ $coin =~ ^[0-9]+$ ]] && ((coin > 0)) || exit 1
done
if ((target == 0)); then echo ""; exit 0; fi

infinity=$((target+1))
best=(); chosen=(); best[0]=0
for ((amount=1; amount<=target; amount++)); do
    best[amount]=$infinity
    for coin in "${coins[@]}"; do
        if ((coin <= amount)); then
            previous=$((amount-coin))
            if ((best[previous]+1 < best[amount])); then
                best[amount]=$((best[previous]+1))
                chosen[amount]=$coin
            fi
        fi
    done
done
if ((best[target] == infinity)); then
    echo "can't make target with given coins"
    exit 1
fi

change=(); amount=$target
while ((amount > 0)); do
    coin=${chosen[amount]}
    change+=("$coin")
    amount=$((amount-coin))
done
sorted=()
for coin in "${change[@]}"; do
    index=${#sorted[@]}
    while ((index > 0)); do
        previous=$((index-1))
        ((sorted[previous] > coin)) || break
        sorted[index]=${sorted[previous]}
        ((index-=1))
    done
    sorted[index]=$coin
done
echo "${sorted[*]}"
