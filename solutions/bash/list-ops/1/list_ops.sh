#!/usr/bin/env bash

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    echo "This library of functions should be sourced into another script" >&2
    exit 4
fi
bash_version=$((10 * BASH_VERSINFO[0] + BASH_VERSINFO[1]))
if (( bash_version < 43 )); then
    echo "This library requires at least bash version 4.3" >&2
    return 4
fi

# Due to inherent bash limitations around word splitting and globbing,
# functions that are intended to *return a list* are instead required to
# receive a nameref parameter, the name of an array variable that will be
# populated in the list function.
# See the filter, map and reverse functions.

# Also note that nameref parameters cannot have the same name as the
# name of the variable in the calling scope.


# Append some elements to the given list.
list::append () {
    local target_name=$1
    shift
    local -n target=$target_name
    target+=( "$@" )
}

# Return only the list elements that pass the given function.
list::filter () {
    local predicate=$1 source_name=$2 result_name=$3 value
    local -n source_list=$source_name result_list=$result_name
    result_list=()
    for value in "${source_list[@]}"; do
        if "$predicate" "$value"; then result_list+=( "$value" ); fi
    done
}

# Transform the list elements, using the given function,
# into a new list.
list::map () {
    local mapper=$1 source_name=$2 result_name=$3 value mapped
    local -n source_list=$source_name result_list=$result_name
    result_list=()
    for value in "${source_list[@]}"; do
        mapped=$("$mapper" "$value") || return
        result_list+=( "$mapped" )
    done
}

# Left-fold the list using the function and the initial value.
list::foldl () {
    local reducer=$1 accumulator=$2 list_name=$3 value
    local -n source_list=$list_name
    for value in "${source_list[@]}"; do
        accumulator=$("$reducer" "$accumulator" "$value") || return
    done
    printf '%s\n' "$accumulator"
}

# Right-fold the list using the function and the initial value.
list::foldr () {
    local reducer=$1 accumulator=$2 list_name=$3 index
    local -n source_list=$list_name
    for ((index=${#source_list[@]}-1; index>=0; index--)); do
        accumulator=$("$reducer" "${source_list[index]}" "$accumulator") || return
    done
    printf '%s\n' "$accumulator"
}

# Return the list reversed
list::reverse () {
    local source_name=$1 result_name=$2 index
    local -n source_list=$source_name result_list=$result_name
    result_list=()
    for ((index=${#source_list[@]}-1; index>=0; index--)); do
        result_list+=( "${source_list[index]}" )
    done
}
