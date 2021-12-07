#!/usr/bin/env bash

set -euo pipefail

round() {
    local divide=$1
    local by=$2
    r=$(echo "scale=3; $divide/$by+0.0005" | bc -l)
    echo ${r%%.*}
}

taskA(){
    local input="$1"

    sorted="$(sed 's/,/\n/g' $input | sort --numeric)"
    size=$(echo "$sorted" | wc -l)
    sum=$(( $(sed 's/,/+/g' $input ) ))

    avg=$(( sum / size ))
    pivot=$(echo "$sorted" | sed -n "$((size / 2 ))p")

    fuel=0
    for crab in $sorted; do
        d=$(( crab - pivot ))
        fuel=$(( fuel + ${d##-} ))
    done


    echo "Total fuel: ${fuel}"
}

taskB() {
    local input="$1"
    sorted="$(sed 's/,/\n/g' $input | sort --numeric)"
    size=$(echo "$sorted" | wc -l)
    sum=$(( $(sed 's/,/+/g' $input ) ))
    pivot=$(round $sum $size)
    fuel=0
    for crab in $sorted; do
        distance=$(( crab - pivot ))
        abs_d=${distance#-}
        f=$(( (abs_d * (1 + abs_d)) / 2 ))
        fuel=$(( fuel + f ))
    done


    echo "Total fuel: ${fuel}"
}

main() {
    taskA input
    taskB input
}

main
