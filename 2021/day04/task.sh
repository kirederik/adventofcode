#!/usr/bin/env bash

set -euo pipefail

_winner() {
    local file="$1"
    while read line; do
        # l=$(echo $line | tr -d " ")
        matches=$(echo "$line" | tr -cd x | wc -c)
        if (( $matches == 5 )); then
            return 0
        fi
    done < $file
    return 1
}

_find_all_winner() {
    winners=""
    for f in $(ls x*); do
        if _winner $f; then
            if [ -z "$winners" ]; then
                winners="$f"
            else
                winners="$winners $f"
            fi
        fi
    done
    echo "$winners"
}

calculate_score() {
    local winner="$1"
    sum=""
    for n in $(cat $winner); do
        if [[ "$n" != "x" ]]; then
            let sum+=$n
        fi
    done
}

prep_games() {
    rm -rf games
    mkdir -p games
    pushd games

    head -2 ../input > called
    tail +3 ../input | split -l 6

    for f in $(ls x*); do
        rs -T < $f > ${f}_t
    done
}

taskA() {
    prep_games

    numbers=$(cat called | tr "," " ")
    winner=""
    last_called=0
    for n in $numbers; do
        echo "called number: $n"
        gsed -i "s/\<$n\>/x/g" x*
        winner="$(_find_all_winner)"
        if [ -n "$winner" ]; then
            last_called=$n
            echo "found a winner!"
            echo $winner
            break
        fi
    done

    calculate_score "$winner"

    echo "Task A: $(( $sum * $last_called ))"

    popd
}

taskB() {
    prep_games

    numbers=$(cat called | tr "," " ")
    winner=""
    last_called=0
    for n in $numbers; do
        echo "called number: $n"
        gsed -i "s/\<$n\>/x/g" x*
        winners="$(_find_all_winner)"
        remaining=$(ls x* | wc -l)
        if (( $remaining == 2 )); then
            if [ -n "$winners" ]; then
                winner=$(ls x* | head -1)
                last_called=$n
                echo "found the last winner: $winner"
                break
            fi
        else
            for winner in $winners; do
                g=${winner%%_*}
                echo "found a winner: ${g}"
                rm -f $g ${g}_t
            done
        fi
    done

    calculate_score "$winner"

    echo "Task A: $(( $sum * $last_called ))"

    popd
}

main() {
    # taskA
    taskB
}

main


