#!/usr/bin/env bash

main () {
    local dna=$1 rna=""

    for ((i = 0; i < ${#dna}; i++)); do
        local nucleotide="${dna:$i:1}"
        case "$nucleotide" in
            C) rna+="G" ;;
            G) rna+="C" ;;
            T) rna+="A" ;;
            A) rna+="U" ;;
            *) echo "Invalid nucleotide detected."; exit 1 ;;
        esac
    done

    echo "$rna"
}

main "$@"
