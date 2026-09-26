#!/usr/bin/env bash

main() {
    local score=$1
    local allergens=("eggs" "peanuts" "shellfish" "strawberries" "tomatoes" "chocolate" "pollen" "cats")
    local values=(1 2 4 8 16 32 64 128)
    local result=()

    if [[ ${2:-} == "allergic_to" ]]; then
        local allergen=${3:-}
        local i
        for i in "${!allergens[@]}"; do
            if [[ ${allergens[i]} == "$allergen" ]]; then
                (( (score & values[i]) == values[i] )) && echo true || echo false
                return
            fi
        done
        echo false
        return
    fi

    for i in "${!values[@]}"; do
        if (( (score & values[i]) == values[i] )); then
            result+=("${allergens[i]}")
        fi
    done

    if [ ${#result[@]} -eq 0 ]; then
        echo ""
    else
        echo "${result[*]}"
    fi
}

main "$@"
