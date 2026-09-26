#!/usr/bin/env bash

# The following comments should help you get started:
# - Bash is flexible. You may use functions or write a "raw" script.
#
# - Complex code can be made easier to read by breaking it up
#   into functions, however this is sometimes overkill in bash.
#
# - You can find links about good style and other resources
#   for Bash in './README.md'. It came with this exercise.
#
#   Example:
#   # other functions here
#   # ...
#   # ...
#
#   main () {
#     # your main function code here
#   }
#
#   # call main with all of the positional arguments
#   main "$@"
#
# *** PLEASE REMOVE THESE COMMENTS BEFORE SUBMITTING YOUR SOLUTION ***
#!/usr/bin/env bash

main() {
    local rna=${1:-} codon protein
    local -a proteins=()
    local i stopped=0
    for ((i=0; i+2<${#rna}; i+=3)); do
        codon=${rna:i:3}
        case $codon in
            AUG) protein=Methionine ;;
            UUU|UUC) protein=Phenylalanine ;;
            UUA|UUG) protein=Leucine ;;
            UCU|UCC|UCA|UCG) protein=Serine ;;
            UAU|UAC) protein=Tyrosine ;;
            UGU|UGC) protein=Cysteine ;;
            UGG) protein=Tryptophan ;;
            UAA|UAG|UGA) stopped=1; break ;;
            *) echo "Invalid codon"; return 1 ;;
        esac
        proteins+=("$protein")
    done
    if ((!stopped && ${#rna} % 3 != 0)); then echo "Invalid codon"; return 1; fi
    local IFS=' '
    echo "${proteins[*]}"
}

main "$@"
