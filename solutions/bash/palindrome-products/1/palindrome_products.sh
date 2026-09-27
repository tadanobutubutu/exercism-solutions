#!/usr/bin/env bash

mode=${1:-}
minimum=${2:-}
maximum=${3:-}
if [[ $mode != smallest && $mode != largest ]]; then
    echo "first arg should be 'smallest' or 'largest'"
    exit 1
fi
if [[ ! $minimum =~ ^[0-9]+$ || ! $maximum =~ ^[0-9]+$ ]]; then
    echo "invalid range"
    exit 1
fi
minimum=$((10#$minimum)); maximum=$((10#$maximum))
if ((minimum > maximum)); then
    echo "min must be <= max"
    exit 1
fi
min_product=$((minimum*minimum))
max_product=$((maximum*maximum))
min_length=${#min_product}
max_length=${#max_product}
found=0

factor_candidate() {
    local factor other
    local -a pairs=()
    for ((factor=minimum; factor*factor<=candidate; factor++)); do
        if ((candidate%factor == 0)); then
            other=$((candidate/factor))
            if ((other >= minimum && other <= maximum)); then
                pairs+=("[$factor, $other]")
            fi
        fi
    done
    if ((${#pairs[@]} > 0)); then
        factors="${pairs[*]}"
        found=1
    fi
}

build_candidate() {
    local prefix=$1 length=$2 reverse='' mirror i
    for ((i=${#prefix}-1; i>=0; i--)); do reverse+=${prefix:i:1}; done
    if ((length % 2 == 1)); then mirror=${reverse:1}; else mirror=$reverse; fi
    candidate=$((10#$prefix$mirror))
    if ((candidate >= min_product && candidate <= max_product)); then factor_candidate; fi
}

if [[ $mode == smallest ]]; then
    for ((length=min_length; length<=max_length && !found; length++)); do
        half=$(((length+1)/2))
        low=1; high=1
        for ((i=1; i<half; i++)); do low=$((low*10)); done
        for ((i=0; i<half; i++)); do high=$((high*10)); done
        high=$((high-1))
        for ((prefix=low; prefix<=high && !found; prefix++)); do
            build_candidate "$prefix" "$length"
        done
    done
else
    for ((length=max_length; length>=min_length && !found; length--)); do
        half=$(((length+1)/2))
        low=1; high=1
        for ((i=1; i<half; i++)); do low=$((low*10)); done
        for ((i=0; i<half; i++)); do high=$((high*10)); done
        high=$((high-1))
        for ((prefix=high; prefix>=low && !found; prefix--)); do
            build_candidate "$prefix" "$length"
        done
    done
fi

if ((found)); then printf '%s: %s\n' "$candidate" "$factors"; fi
