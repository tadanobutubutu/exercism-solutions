#!/usr/bin/env bash

year=${1:-0}
month=${2:-0}
week=${3:-}
weekday=${4:-}
if [[ ! $year =~ ^[0-9]+$ || ! $month =~ ^[0-9]+$ ]]; then exit 1; fi
year=$((10#$year)); month=$((10#$month))
case $month in
    1|3|5|7|8|10|12) days=31 ;;
    4|6|9|11) days=30 ;;
    2)
        if ((year%400 == 0 || (year%4 == 0 && year%100 != 0))); then days=29; else days=28; fi
        ;;
    *) exit 1 ;;
esac
case $weekday in
    Sunday) target=0 ;;
    Monday) target=1 ;;
    Tuesday) target=2 ;;
    Wednesday) target=3 ;;
    Thursday) target=4 ;;
    Friday) target=5 ;;
    Saturday) target=6 ;;
    *) exit 1 ;;
esac
case $week in
    first) occurrence=1 ;;
    second) occurrence=2 ;;
    third) occurrence=3 ;;
    fourth) occurrence=4 ;;
    last|teenth) occurrence=0 ;;
    *) exit 1 ;;
esac

found=0
seen=0
for ((day=1; day<=days; day++)); do
    zmonth=$month
    zyear=$year
    if ((zmonth < 3)); then zmonth=$((zmonth+12)); zyear=$((zyear-1)); fi
    zeller=$(((day + 13*(zmonth+1)/5 + zyear + zyear/4 - zyear/100 + zyear/400) % 7))
    dow=$(((zeller+6)%7))
    ((dow == target)) || continue
    if [[ $week == teenth ]]; then
        if ((day >= 13 && day <= 19)); then found=$day; break; fi
    elif [[ $week == last ]]; then
        found=$day
    else
        ((seen+=1))
        if ((seen == occurrence)); then found=$day; break; fi
    fi
done
((found > 0)) || exit 1
printf '%04d-%02d-%02d\n' "$year" "$month" "$found"
