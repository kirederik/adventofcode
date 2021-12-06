#!/usr/bin/env bash

set -euo pipefail

_add_to_stage() {
    local stage="$1"
    local incr="$2"
    v=$(cat $stage)
    echo $(( v + incr )) > $stage
}

create_fishes() {
    local input="$1"
    rm -rf fishes
    mkdir -p fishes
    pushd fishes >/dev/null
    for i in $(seq 0 8); do
        echo "0" >> $i
    done
    for stage in $(sed "s/,/ /g" ../$input); do
        _add_to_stage $stage 1
    done
    popd >/dev/null
}

_reproduce() {
    ready=$(cat 0)

    for i in $(seq 8); do
        cat ${i} > $((i-1))
    done
    echo $ready > 8

    _add_to_stage 6 $ready
}

_iterate() {
    create_fishes "input"
    local days=$1

    pushd fishes >/dev/null
    for i in $(seq $days); do
        _reproduce
    done

    sum=0
    for i in $(seq 0 8); do
        v=$(cat ${i})
        sum=$(( sum + v ))
    done
    echo -n "$sum"

    popd >/dev/null
}

taskA() {
    echo -n "Task A: "
    _iterate 80
    echo ""
}

taskB() {
    echo -n "Task B: "
    _iterate 256
    echo ""
}

main() {
    taskA
    taskB
}

main
