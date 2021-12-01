#!/usr/bin/env bash

set -eo pipefail

calculateIncreaseWithWindow() {
    local all=($@)
    local length=${#all[@]}
    local increased=0
    for (( i=3; i<length; i++ )) do
        wStart=${all[j]}
        curr=${all[i]}
        if (( $wStart < $curr )); then
            let ++increased
        fi
        let ++j
    done
    echo "Task B: $increased"
}

calculateIncreases() {
    local prev="$1"
    local all="${@:2}"

    local increased=0
    for next in ${all[@]}; do
        if (( $next > $prev )); then
            let ++increased
        fi
        prev=$next
    done

    echo "Task A: $increased"
}

main() {
    input=$(< ./input)
    calculateIncreases $input
    calculateIncreaseWithWindow $input
}

main
