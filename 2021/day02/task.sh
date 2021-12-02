#!/usr/bin/env bash

set -eo pipefail

count() {
    local key="$1"
    echo "$(grep ${key} input | cut -w -f2 | tr '\n' '+')0" | bc -l
}

taskA() {
    local forward=$(count 'forward')
    local down=$(count 'down')
    local up=$(count 'up')

    result=$(echo "$forward * ($down - $up)" | bc -l)

    echo "Task A: ${result}"
}

taskB() {
    local all="$@"
    aim=0
    depth=0
    position=0

    while read instruction; do
        direction="$(echo "$instruction" | cut -w -f1)"
        units="$(echo "$instruction" | cut -w -f2)"
        case $direction in
            forward)
                let position+=$units
                depth=$(echo "$depth + $units * $aim" | bc -l)
                ;;
            down)
                let aim+=$units
                ;;
            up)
                let aim-=$units
                ;;
        esac
    done < input
    result=$(echo "$position * $depth" | bc -l)

    echo "Task B: ${result}"
}

main() {
    taskA
    taskB
}

main
