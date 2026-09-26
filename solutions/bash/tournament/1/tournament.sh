#!/usr/bin/env bash

find_team() {
    local wanted=$1 i
    for i in "${!teams[@]}"; do
        if [[ ${teams[i]} == "$wanted" ]]; then found_index=$i; return 0; fi
    done
    found_index=-1
}

ensure_team() {
    local name=$1
    find_team "$name"
    if ((found_index < 0)); then
        teams+=("$name"); matches+=(0); wins+=(0); draws+=(0); losses+=(0); points+=(0)
        found_index=$((${#teams[@]}-1))
    fi
}

read_matches() {
    local line team1 team2 outcome i1 i2
    while IFS= read -r line || [[ -n $line ]]; do
        [[ -n $line ]] || continue
        IFS=';' read -r team1 team2 outcome <<< "$line"
        ensure_team "$team1"; i1=$found_index
        ensure_team "$team2"; i2=$found_index
        matches[i1]=$((matches[i1]+1)); matches[i2]=$((matches[i2]+1))
        case $outcome in
            win) wins[i1]=$((wins[i1]+1)); losses[i2]=$((losses[i2]+1)); points[i1]=$((points[i1]+3)) ;;
            loss) losses[i1]=$((losses[i1]+1)); wins[i2]=$((wins[i2]+1)); points[i2]=$((points[i2]+3)) ;;
            draw) draws[i1]=$((draws[i1]+1)); draws[i2]=$((draws[i2]+1)); points[i1]=$((points[i1]+1)); points[i2]=$((points[i2]+1)) ;;
        esac
    done
}

main() {
    local -a teams=() matches=() wins=() draws=() losses=() points=() printed=()
    local found_index best i
    if (($# > 1)); then echo "usage: tournament.sh [file]" >&2; return 1; fi
    if (($# == 1)); then read_matches < "$1"; else read_matches; fi
    printf 'Team                           | MP |  W |  D |  L |  P\n'
    for ((i=0; i<${#teams[@]}; i++)); do printed[i]=0; done
    while :; do
        best=-1
        for i in "${!teams[@]}"; do
            ((printed[i])) && continue
            if ((best < 0)); then best=$i
            elif ((points[i] > points[best])); then best=$i
            elif ((points[i] == points[best])) && [[ ${teams[i]} < ${teams[best]} ]]; then best=$i
            fi
        done
        ((best >= 0)) || break
        printed[best]=1
        printf '%-31s| %2d | %2d | %2d | %2d | %2d\n' "${teams[best]}" "${matches[best]}" "${wins[best]}" "${draws[best]}" "${losses[best]}" "${points[best]}"
    done
}

LC_ALL=C main "$@"
