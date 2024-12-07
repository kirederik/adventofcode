package day07

import (
	"fmt"
	"strconv"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

func getElements(l string) (int64, []int64) {
	split := strings.Split(l, ":")

	numbersStr := strings.Fields(split[1])

	target, _ := strconv.ParseInt(split[0], 10, 64)
	numbers := make([]int64, len(numbersStr))
	for i, n := range numbersStr {
		numbers[i], _ = strconv.ParseInt(n, 10, 64)
	}
	return target, numbers
}

func valid(target int64, acc int64, numbers []int64) bool {
	if len(numbers) == 0 {
		return acc == target
	}

	head := numbers[0]
	tail := numbers[1:]
	return valid(target, acc+head, tail) || valid(target, acc*head, tail)

}

func validConcat(target int64, acc int64, numbers []int64) bool {
	if len(numbers) == 0 {
		return acc == target
	}

	head := numbers[0]
	tail := numbers[1:]

	concat, _ := strconv.ParseInt(fmt.Sprintf("%d%d", acc, head), 10, 64)
	return validConcat(target, acc+head, tail) || validConcat(target, acc*head, tail) || validConcat(target, concat, tail)
}

func Puzzle01(inputPath string) int64 {
	equations := lib.Read(inputPath)
	var count int64

	for _, eq := range equations {
		target, numbers := getElements(eq)

		if valid(target, 0, numbers) {
			count += target
		}
	}
	return count
}

func Puzzle02(inputPath string) int64 {
	equations := lib.Read(inputPath)
	var count int64

	for _, eq := range equations {
		target, numbers := getElements(eq)

		if validConcat(target, 0, numbers) {
			count += target
		}
	}
	return count
}
