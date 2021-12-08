#!/usr/bin/env bash

set -euo pipefail

_sort_chars() {
    read line
    echo "$line" | grep -o . | sort | tr -d "\n"
}

_contain() {
    local s="$1"
    local chars="$2"
    contain=0
    chars=$(echo $chars | grep -o .)
    for c in $chars; do
        if [[ ! $s =~ $c ]]; then
            contain=1
            break
        fi
    done

    return $contain
}

_find_containing() {
    local chars="$1"
    set +x
    while read s; do
        _contain $s "$chars" && echo "$s"
    done
    set +x
}

taskA() {
    local input=$1
    output=$(cut -d"|" -f2 $input | sed 's/^ *//;s/ *$//')

    ones=0
    sevens=0
    fours=0
    eights=0
    while read line; do
        for n in $line; do
            (( ${#n} == 2 )) && (( ones = ones + 1 ))
            (( ${#n} == 3 )) && (( sevens = sevens + 1 ))
            (( ${#n} == 4 )) && (( fours = fours + 1 ))
            (( ${#n} == 7 )) && (( eights = eights + 1 ))
        done
    done < <(echo "$output")

    echo -e "1s: ${ones}\n4s: ${fours}\n7s: ${sevens}\n8s: ${eights}"
    echo $(( ones + fours + sevens + eights ))
}

taskB() {
    local input=$1
    local total=0
    while read line; do
        unqs=$(echo $line | cut -d"|" -f 1)
        f=$(echo "$unqs" | sed 's/ /\n/g' | awk '{ print length, $0 }' | sort -n | cut -d" " -f2- | sed '$ d')
        output=$(echo $line | cut -d"|" -f 2 | sed 's/^ *//;s/*$//')

        eight="abcdefg"
        one=$(echo "$f" | tail +2 | head -1)
        f=$(echo "$f" | tail +3)

        seven=$(echo "$f" | head -1)
        f=$(echo "$f" | tail +2)

        four=$(echo "$f" | head -1)
        f=$(echo "$f" | tail +2)

        three=$(echo "$f" | head -3 | _find_containing $one)
        two_or_five=$(echo "$f" | grep -v $three | head -2)
        f=$(echo "$f" | tail +4)

        nine=$(echo "$f" | _find_containing $three)
        zero_or_six=$(echo "$f" | grep -v $nine)

        maybe_five=$(echo "$two_or_five" | head -1)
        maybe_two=$(echo "$two_or_five" | tail -1)
        maybe_six=$(echo "$zero_or_six" | head -1)
        maybe_zero=$(echo "$zero_or_six" | tail -1)

        if _contain $maybe_six $maybe_five; then
            five=$maybe_five
            two=$maybe_two
            six=$maybe_six
            zero=$maybe_zero
        elif _contain $maybe_zero $maybe_five; then
            five=$maybe_five
            two=$maybe_two
            zero=$maybe_six
            six=$maybe_zero
        elif _contain $maybe_six $maybe_two; then
            five=$maybe_two
            two=$maybe_five
            zero=$maybe_zero
            six=$maybe_six
        else
            five=$maybe_two
            two=$maybe_five
            six=$maybe_zero
            zero=$maybe_six
        fi

        sorted_output=""
        for s in $output; do
            sorted_output="${sorted_output}$(echo "$s"| _sort_chars) "
        done

        i=0
        regexp=""
        for c in $zero $one $two $three $four $five $six $seven $eight $nine; do
            regexp="${regexp}s/\<$(echo "$c" | _sort_chars)\>/${i}/g;"
            (( i = i + 1 ))
        done

        value=$(echo "$sorted_output" | gsed "$regexp")
        echo "$value"

        sum=$(echo "${value%%?}" | tr -d " " | bc -l)

        (( total = total + sum ))
    done < $input

    echo "$total"
}

main() {
    taskA input
    taskB input
}

main
