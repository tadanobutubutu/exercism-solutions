#!/usr/bin/env bash

diagram=${1:-}
student=${2:-}
students=(Alice Bob Charlie David Eve Fred Ginny Harriet Ileana Joseph Kincaid Larry)
student_index=-1
for ((i=0; i<${#students[@]}; i++)); do
    if [[ ${students[i]} == "$student" ]]; then student_index=$i; break; fi
done
((student_index >= 0)) || exit 1
top=${diagram%%$'\n'*}
bottom=${diagram#*$'\n'}
[[ $bottom == "$diagram" ]] && bottom=''
column=$((student_index*2))
output=()
for plant in "${top:column:1}" "${top:column+1:1}" "${bottom:column:1}" "${bottom:column+1:1}"; do
    case $plant in
        G) output+=(grass) ;;
        C) output+=(clover) ;;
        R) output+=(radishes) ;;
        V) output+=(violets) ;;
        *) exit 1 ;;
    esac
done
echo "${output[*]}"
