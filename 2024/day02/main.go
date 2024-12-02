package day02

import (
	"github.com/kirederik/adventofcode/2024/lib"
)

func safeDiff(dec bool, diff int) bool {
	if !dec {
		diff *= -1
	}
	return diff != 0 && diff < 4
}

func safeTrend(dec bool, a, b int) bool {
	if dec {
		return a < b
	}
	return a > b
}

func isSafe(report []int) (bool, int) {
	last := report[0]
	var dec bool
	if last < report[1] {
		dec = true
	}

	for i := 1; i < len(report); i++ {
		diff := report[i] - last

		if !safeDiff(dec, diff) || !safeTrend(dec, last, report[i]) {
			return false, i - 1
		}

		last = report[i]
	}

	return true, 0
}

func remove(report []int, index int) []int {
	l := make([]int, len(report)-1)
	if index < 0 {
		index = 0
	}
	if index > len(report) {
		index = len(report) - 1
	}

	var j int
	for i := 0; i < len(report); i++ {
		if i == index {
			continue
		}
		l[j] = report[i]
		j++
	}

	return l
}

func assertSafety(reports [][]int, dampened bool) int {
	var safeCount int
	for _, report := range reports {
		safe, index := isSafe(report)
		if safe {
			safeCount++
			continue
		}

		if dampened {
			for i := index - 1; i < index+2; i++ {
				safe, _ = isSafe(remove(report, i))
				if safe {
					safeCount++
					break
				}
			}
		}
	}
	return safeCount
}

func parseInput(inputPath string) [][]int {
	content := lib.Read(inputPath)
	reports := make([][]int, len(content))
	for i, line := range content {
		ints := lib.ParseLine(line)
		reports[i] = make([]int, len(ints))
		reports[i] = ints
	}
	return reports
}

func Puzzle01(inputPath string) int {
	return assertSafety(parseInput(inputPath), false)
}

func Puzzle02(inputPath string) int {
	return assertSafety(parseInput(inputPath), true)
}
