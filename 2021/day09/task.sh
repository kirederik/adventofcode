#!/usr/bin/env bash

set -euo pipefail
_number_at() {
    local lines="$1"
    local row="$2"
    local col="$3"

    (( row < 0  || col <= 0 )) && echo 999 && return 0
    n=$(echo "$lines" | grep "^${row}\:" | cut -d":" -f2 | cut -c "$col")

    [ -z "$n" ]  && echo 999 || echo ${n}
}

taskA() {
    local input=$1

    (( cols = $(head -1 $1 | wc -c) - 1 ))
    (( rows = $(wc -l < $input ) + 1))

    grid="$(grep -n '.' $input)" # add row number to the grid

    sum=0
    for (( i = 1; i <= rows; i++ )); do
        echo "row ${i}"
        target="$(echo "$grid" | grep "^${i}\:" --after 1 --before 1)"
        for (( j = 1; j <= cols; j++ )); do
            n=$(_number_at "$target" "$i" "$j")
            above=$(_number_at "$target" $((i-1)) "$j")
            below=$(_number_at "$target" $((i+1)) "$j")
            left=$(_number_at "$target" $i "$((j-1))")
            right=$(_number_at "$target" $i "$((j+1))")

            (( n < above && n < below && n < left && n < right )) && (( sum = sum + n + 1 ))
        done
    done

    echo $sum
}

taskB() {
    ruby taskB.rb
}

main() {
    taskA input
    taskB testinput
}

reset
main
