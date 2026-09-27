#!/usr/bin/env bash

tokens=()
while IFS= read -r line || [[ -n $line ]]; do
    read -r -a words <<< "$line"
    for word in "${words[@]}"; do
        word=$(printf '%s' "$word" | tr '[:upper:]' '[:lower:]')
        tokens+=("$word")
    done
done

stack=()
def_names=()
def_bodies=()
pre_error() { echo "$1"; exit 1; }
find_definition() {
    local wanted=$1 index
    definition_index=-1
    for ((index=${#def_names[@]}-1; index>=0; index--)); do
        if [[ ${def_names[index]} == "$wanted" ]]; then definition_index=$index; return 0; fi
    done
}
expand_word() {
    find_definition "$1"
    if ((definition_index >= 0)); then expanded=${def_bodies[definition_index]}; else expanded=$1; fi
}
run_primitive() {
    local operation=$1 depth left right value
    if [[ $operation =~ ^-?[0-9]+$ ]]; then stack+=("$operation"); return 0; fi
    depth=${#stack[@]}
    case $operation in
        +|-|\*|/)
            ((depth > 0)) || pre_error "empty stack"
            ((depth > 1)) || pre_error "only one value on the stack"
            left=${stack[depth-2]}; right=${stack[depth-1]}
            stack=("${stack[@]:0:depth-2}")
            case $operation in
                +) value=$((left+right)) ;;
                -) value=$((left-right)) ;;
                \*) value=$((left*right)) ;;
                /)
                    ((right != 0)) || pre_error "divide by zero"
                    value=$((left/right))
                    ;;
            esac
            stack+=("$value")
            ;;
        dup)
            ((depth > 0)) || pre_error "empty stack"
            stack+=("${stack[depth-1]}")
            ;;
        drop)
            ((depth > 0)) || pre_error "empty stack"
            stack=("${stack[@]:0:depth-1}")
            ;;
        swap)
            ((depth > 0)) || pre_error "empty stack"
            ((depth > 1)) || pre_error "only one value on the stack"
            left=${stack[depth-2]}; right=${stack[depth-1]}
            stack[depth-2]=$right; stack[depth-1]=$left
            ;;
        over)
            ((depth > 0)) || pre_error "empty stack"
            ((depth > 1)) || pre_error "only one value on the stack"
            stack+=("${stack[depth-2]}")
            ;;
        *) pre_error "undefined operation: $operation" ;;
    esac
}

index=0
while ((index < ${#tokens[@]})); do
    token=${tokens[index]}
    if [[ $token == : ]]; then
        ((index+1 < ${#tokens[@]})) || pre_error "illegal operation"
        name=${tokens[index+1]}
        [[ $name =~ ^-?[0-9]+$ ]] && pre_error "illegal operation"
        name_body=''
        index=$((index+2))
        while ((index < ${#tokens[@]})) && [[ ${tokens[index]} != \; ]]; do
            expand_word "${tokens[index]}"
            name_body+="${name_body:+ }$expanded"
            ((index+=1))
        done
        ((index < ${#tokens[@]})) || pre_error "illegal operation"
        find_definition "$name"
        if ((definition_index >= 0)); then
            def_bodies[definition_index]=$name_body
        else
            def_names+=("$name")
            def_bodies+=("$name_body")
        fi
        ((index+=1))
        continue
    fi
    find_definition "$token"
    if ((definition_index >= 0)); then
        body=${def_bodies[definition_index]}
        read -r -a body_tokens <<< "$body"
        for operation in "${body_tokens[@]}"; do run_primitive "$operation"; done
    else
        run_primitive "$token"
    fi
    ((index+=1))
done
echo "${stack[*]}"
