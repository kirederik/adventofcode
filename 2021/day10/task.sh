#!/usr/bin/env bash

set -eo pipefail

_match() {
    local open=$1
    local close=$2

    (( open < close && open+1 == close ))
}

_points() {
    local close=$1
    case $close in
        2)
            echo 3
            ;;
        4)
            echo 57
            ;;
        6)
            echo 1197
            ;;
        8)
            echo 25137
            ;;
        *)
            echo 0
            ;;
    esac
}

taskA() {
    local input=$1

    tr "(" "1" < $1 | tr ")" "2" | tr "{" "3" | tr "}" "4" | tr "[" "5" | tr "]" "6" | tr "<" "7" | tr ">" "8" > bash_friendly_input
    pos=0
    total=0
    while read line; do
        tokens=$(echo "$line" | grep -o '.')
        for token in $tokens; do
            if [[ "$token" =~ [1|3|5|7] ]]; then
                arr=(${arr[@]} $token)
            elif [[ "$token" =~ [2|4|6|8] ]]; then
                last=${arr[@]:0-1}
                if _match $last $token; then
                    arr=( ${arr[@]:0:$((${#arr[@]}-1))} )
                else
                    (( total += $(_points $token) ))
                    break
                fi
            fi
        done
    done < bash_friendly_input

    echo $total
}



taskA input
