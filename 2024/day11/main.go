package day11

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

func calcNextVal(val int64) []int64 {
	if val == 0 {
		return []int64{1}
	}

	strVal := fmt.Sprintf("%d", val)
	if len(strVal)%2 == 0 {
		mid := len(strVal) / 2
		left, _ := strconv.ParseInt(strVal[:mid], 10, 64)
		right, _ := strconv.ParseInt(strVal[mid:], 10, 64)
		return []int64{left, right}

	}

	return []int64{val * 2024}
}

func calcBlinks(val int64, blinks int, cache map[int64]map[int]int64) int64 {
	if v, found := cache[val][blinks]; found {
		return v
	}
	next := calcNextVal(val)
	if blinks == 1 {
		return int64(len(next))
	}

	count := calcBlinks(next[0], blinks-1, cache)
	if len(next) == 2 {
		count += calcBlinks(next[1], blinks-1, cache)
	}
	if cache[val] == nil {
		cache[val] = map[int]int64{}
	}
	cache[val][blinks] = count
	return count
}

func run(inputPath string, blinks int) int64 {
	line := lib.Read(inputPath)

	stones := []int64{}
	for _, l := range strings.Split(line[0], " ") {
		num, _ := strconv.ParseInt(l, 10, 64)
		stones = append(stones, num)
	}

	var count int64
	cache := map[int64]map[int]int64{}
	for _, stone := range stones {
		count += calcBlinks(stone, blinks, cache)
	}
	return count
}

func Puzzle01(inputPath string) int64 {
	return run(inputPath, 25)
}

func Puzzle02(inputPath string) int64 {
	return run(inputPath, 75)
}
