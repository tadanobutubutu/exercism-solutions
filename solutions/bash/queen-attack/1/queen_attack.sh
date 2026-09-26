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
    local white='' black='' flag
    while (($#)); do
        flag=$1
        if (($# < 2)); then echo "invalid arguments"; return 1; fi
        case $flag in
            -w) white=$2 ;;
            -b) black=$2 ;;
            *) echo "invalid arguments"; return 1 ;;
        esac
        shift 2
    done
    [[ $white =~ ^-?[0-9]+,-?[0-9]+$ && $black =~ ^-?[0-9]+,-?[0-9]+$ ]] || { echo "invalid position"; return 1; }
    local wr=${white%%,*} wc=${white#*,} br=${black%%,*} bc=${black#*,}
    if ((wr < 0)); then echo "row not positive"; return 1; fi
    if ((wr > 7)); then echo "row not on board"; return 1; fi
    if ((wc < 0)); then echo "column not positive"; return 1; fi
    if ((wc > 7)); then echo "column not on board"; return 1; fi
    if ((br < 0)); then echo "row not positive"; return 1; fi
    if ((br > 7)); then echo "row not on board"; return 1; fi
    if ((bc < 0)); then echo "column not positive"; return 1; fi
    if ((bc > 7)); then echo "column not on board"; return 1; fi
    if ((wr == br && wc == bc)); then echo "same position"; return 1; fi
    local dr=$((wr - br)) dc=$((wc - bc))
    ((dr < 0)) && dr=$((-dr))
    ((dc < 0)) && dc=$((-dc))
    if ((wr == br || wc == bc || dr == dc)); then echo true; else echo false; fi
}

main "$@"
