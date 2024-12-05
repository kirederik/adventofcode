package day05

import (
	"slices"
	"strconv"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

func parseInput(inputPath string) (map[string][]string, []string) {
	lines := lib.Read(inputPath)

	var updates []string
	pageOrdering := map[string][]string{}
	for i, line := range lines {
		if line == "" {
			updates = lines[i+1:]
			break
		}

		pages := strings.Split(line, "|")
		before := pages[0]
		aft := pages[1]

		if deps, found := pageOrdering[before]; found {
			pageOrdering[before] = append(deps, aft)
		} else {
			pageOrdering[before] = []string{aft}
		}
	}
	return pageOrdering, updates
}

func validOrder(printed []string, curr string, order map[string][]string) bool {
	for _, p := range printed {
		if slices.Contains(order[p], curr) {
			return false
		}
	}

	return true
}

func Puzzle01(inputPath string) int {
	var count int

	order, updates := parseInput(inputPath)

	for _, update := range updates {
		pages := strings.Split(update, ",")
		printed := []string{}
		valid := true
		for i := len(pages) - 1; i >= 0 && valid; i-- {
			curr := pages[i]
			if validOrder(printed, curr, order) {
				printed = append(printed, curr)
			} else {
				valid = false
			}
		}

		if valid {
			n, _ := strconv.Atoi(pages[len(pages)/2])
			count += n
		}
	}

	return count
}

func fix(pages []string, order map[string][]string) []string {
	fixed := []string{}

	for j, curr := range pages {
		i := j

		for k := j - 1; k >= 0; k-- {
			if slices.Contains(order[fixed[k]], curr) {
				i = k
			}
		}

		fixed = slices.Insert(fixed, i, curr)
	}

	return fixed
}

func Puzzle02(inputPath string) int {
	order, updates := parseInput(inputPath)
	var count int

	for _, update := range updates {
		pages := strings.Split(update, ",")
		printed := []string{}
		valid := true
		for i := len(pages) - 1; i >= 0 && valid; i-- {
			curr := pages[i]
			if validOrder(printed, curr, order) {
				printed = append(printed, curr)
			} else {
				fixed := fix(pages, order)
				n, _ := strconv.Atoi(fixed[len(fixed)/2])
				count += n
				break
			}
		}
	}

	return count

}
