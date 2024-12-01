package day01

import (
	"slices"

	"github.com/kirederik/adventofcode/2024/lib"
)

func Puzzle01(inputPath string) int {
	// distance of two lists
	content := lib.Read(inputPath)

	l0 := make([]int, len(content))
	l1 := make([]int, len(content))
	for i, line := range content {
		ints := lib.ParseLine(line)
		l0[i] = ints[0]
		l1[i] = ints[1]
	}

	slices.Sort(l0)
	slices.Sort(l1)

	var ans int
	for i := range l0 {
		distance := l0[i] - l1[i]
		if distance < 0 {
			distance *= -1
		}
		ans += distance
	}

	return ans
}

func Puzzle02(inputPath string) int {
	// similarity of the two lists
	content := lib.Read(inputPath)

	left := make([]int, len(content))
	right := map[int]int{}
	for i, line := range content {
		ints := lib.ParseLine(line)
		left[i] = ints[0]
		right[ints[1]] += ints[1]
	}

	var ans int
	for _, v := range left {
		ans += right[v]
	}

	return ans
}
