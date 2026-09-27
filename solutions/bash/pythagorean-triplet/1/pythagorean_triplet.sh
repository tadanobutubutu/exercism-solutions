#!/usr/bin/env bash

sum=${1:-}
[[ $sum =~ ^[0-9]+$ ]] || exit 1
sum=$((10#$sum))

gcd() {
    local a=$1 b=$2 temp
    while ((b != 0)); do temp=$((a%b)); a=$b; b=$temp; done
    echo "$a"
}

for ((m=2; 2*m*(m+1)<=sum; m++)); do
    for ((n=1; n<m; n++)); do
        divisor=$((2*m*(m+n)))
        ((sum % divisor == 0)) || continue
        (( $(gcd "$m" "$n") == 1 )) || continue
        (( (m-n) % 2 == 1 )) || continue
        scale=$((sum/divisor))
        a=$((scale*(m*m-n*n)))
        b=$((scale*2*m*n))
        c=$((scale*(m*m+n*n)))
        if ((a > b)); then temp=$a; a=$b; b=$temp; fi
        printf '%d,%d,%d\n' "$a" "$b" "$c"
    done
done
