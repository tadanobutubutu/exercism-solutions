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
    local start=${1:-} end=${2:-}
    [[ $start =~ ^[0-9]+$ && $end =~ ^[0-9]+$ ]] || return 1
    start=$((10#$start)); end=$((10#$end))
    ((start >= 1 && end <= 12 && start <= end)) || { echo "invalid day range"; return 1; }
    local -a ordinals=("" first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth)
    local -a numbers=("" one two three four five six seven eight nine ten eleven twelve)
    local -a gifts=("" "a Partridge in a Pear Tree" "two Turtle Doves" "three French Hens" "four Calling Birds" "five Gold Rings" "six Geese-a-Laying" "seven Swans-a-Swimming" "eight Maids-a-Milking" "nine Ladies Dancing" "ten Lords-a-Leaping" "eleven Pipers Piping" "twelve Drummers Drumming")
    local day gift line items
    for ((day=start; day<=end; day++)); do
        line="On the ${ordinals[day]} day of Christmas my true love gave to me: "
        items=""
        for ((gift=day; gift>=1; gift--)); do
            if ((gift == 1)); then
                [[ $day == 1 ]] && items="a Partridge in a Pear Tree" || items+=", and a Partridge in a Pear Tree"
            elif ((gift == day)); then items=${gifts[gift]}
            else items+=", ${gifts[gift]}"
            fi
        done
        printf '%s%s.\n' "$line" "$items"
    done
}

main "$@"
