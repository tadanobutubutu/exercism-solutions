#!/usr/bin/env bash

preorder=(); inorder=()
read -r -a preorder <<< "${1:-}"
read -r -a inorder <<< "${2:-}"
pre_count=${#preorder[@]}; in_count=${#inorder[@]}
if ((pre_count != in_count)); then echo "traversals must have the same length"; exit 1; fi

for ((i=0; i<pre_count; i++)); do
    for ((j=i+1; j<pre_count; j++)); do
        if [[ ${preorder[i]} == "${preorder[j]}" ]]; then
            echo "traversals must contain unique items"
            exit 1
        fi
    done
done
for ((i=0; i<in_count; i++)); do
    for ((j=i+1; j<in_count; j++)); do
        if [[ ${inorder[i]} == "${inorder[j]}" ]]; then
            echo "traversals must contain unique items"
            exit 1
        fi
    done
done
for value in "${preorder[@]}"; do
    found=0
    for other in "${inorder[@]}"; do
        if [[ $value == "$other" ]]; then found=1; break; fi
    done
    if ((found == 0)); then echo "traversals must have the same elements"; exit 1; fi
done

build_json() {
    local low=$1 high=$2 root position left_json right_json i
    if ((low > high)); then tree_json='{}'; return 0; fi
    ((pre_index < pre_count)) || { echo "traversals must have the same elements"; exit 1; }
    root=${preorder[pre_index]}
    ((pre_index+=1))
    position=-1
    for ((i=low; i<=high; i++)); do
        if [[ ${inorder[i]} == "$root" ]]; then position=$i; break; fi
    done
    ((position >= 0)) || { echo "traversals must have the same elements"; exit 1; }
    build_json "$low" "$((position-1))"
    left_json=$tree_json
    build_json "$((position+1))" "$high"
    right_json=$tree_json
    tree_json="{\"v\":\"$root\",\"l\":$left_json,\"r\":$right_json}"
}

pre_index=0
build_json 0 "$((pre_count-1))"
((pre_index == pre_count)) || { echo "traversals must have the same elements"; exit 1; }
echo "$tree_json"
