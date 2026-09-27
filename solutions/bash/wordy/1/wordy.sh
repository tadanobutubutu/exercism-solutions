#!/usr/bin/env bash

fail() { echo "$1"; exit 1; }
normalize_integer() {
    local raw=$1 sign=''
    if [[ $raw == -* ]]; then sign=-; raw=${raw#-}; fi
    while ((${#raw} > 1)) && [[ ${raw:0:1} == 0 ]]; do raw=${raw#0}; done
    [[ -n $raw ]] || raw=0
    normalized="$sign$raw"
}

question=${1:-}
[[ $question == "What is?" ]] && fail "syntax error"
[[ $question == "What is "* ]] || fail "unknown operation"
expression=${question#What is }
[[ $expression == *\? ]] || fail "syntax error"
expression=${expression%\?}
tokens=()
read -r -a tokens <<< "$expression"
count=${#tokens[@]}
((count > 0)) || fail "syntax error"

first=${tokens[0]}
[[ $first =~ ^-?[0-9]+$ ]] || {
    case $first in plus|minus|multiplied|divided) fail "syntax error" ;; *) fail "unknown operation" ;; esac
}
normalize_integer "$first"
result=$normalized
index=1
while ((index < count)); do
    operator=${tokens[index]}
    case $operator in
        plus) operation=add; ((index+=1)) ;;
        minus) operation=subtract; ((index+=1)) ;;
        multiplied)
            if ((index+1 < count)) && [[ ${tokens[index+1]} == by ]]; then
                operation=multiply; ((index+=2))
            else
                fail "unknown operation"
            fi
            ;;
        divided)
            if ((index+1 < count)) && [[ ${tokens[index+1]} == by ]]; then
                operation=divide; ((index+=2))
            else
                fail "unknown operation"
            fi
            ;;
        *)
            [[ $operator =~ ^-?[0-9]+$ ]] && fail "syntax error"
            fail "unknown operation"
            ;;
    esac
    ((index < count)) || fail "syntax error"
    operand=${tokens[index]}
    [[ $operand =~ ^-?[0-9]+$ ]] || fail "syntax error"
    normalize_integer "$operand"
    operand=$normalized
    case $operation in
        add) result=$((result+operand)) ;;
        subtract) result=$((result-operand)) ;;
        multiply) result=$((result*operand)) ;;
        divide)
            ((operand != 0)) || fail "division by zero"
            result=$((result/operand))
            ;;
    esac
    ((index+=1))
done
echo "$result"
