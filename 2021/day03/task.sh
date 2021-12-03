#!/usr/bin/env bash

set -euo pipefail

count() {
    local col=$1
    local n=$2
    local file=${3:-'input'}
    cut -c${col} ${file} | grep $n | wc -l | tr -d ' '
}

count_lines() {
    wc -l < $1 | tr -d ' '
}

reduce() {
    local file="$1"
    local conditional="$2"

    col=1
    offset=""
    lines=$(count_lines $oxygen)

    while (( $lines > 1 )); do
        ones=$(count $col '1' $file)
        threshold=$(bc <<< "($lines+1)/2")
        n=0
        if (( $ones $conditional $threshold )); then
            n=1
        fi
        grep "^${offset}${n}" $file > /tmp/temp_file && cp /tmp/temp_file $file
        offset=".${offset}"
        lines=$(count_lines $file)
        let col+=1
    done

}

taskB() {
    oxygen="/tmp/oxygen"
    co2="/tmp/co2"
    cp input $oxygen
    cp input $co2

    reduce $co2 "<"
    reduce $oxygen ">="

    oxygen=$(cat $oxygen)
    co2=$(cat $co2)
    echo "Oxygen: $oxygen"
    echo "CO2: $co2"

    echo "Task B: $(( $((2#${oxygen})) * $((2#${co2})) ))"
}

taskA() {
    gamma=""
    epsilon=""
    for i in $(seq 12); do
        ones=$(count $i '1')
        zeros=$(count $i '0')
        if (( $ones > $zeros )); then
            gamma="${gamma}1"
            epsilon="${epsilon}0"
        else
            gamma="${gamma}0"
            epsilon="${epsilon}1"
        fi
    done

    gamma=$((2#${gamma}))
    epsilon=$((2#${epsilon}))

    echo "Task A: $(( $gamma * $epsilon ))"
}

main() {
    taskA
    echo "--"
    taskB
}

main
