package lib

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func check(err error) {
	if err != nil {
		fmt.Println("Fail: ", err)
		os.Exit(1)
	}
}
func Read(path string) []string {
	f, err := os.ReadFile(path)
	check(err)
	lines := strings.Split(string(f), "\n")
	if lines[len(lines)-1] == "" {
		return lines[:len(lines)-1]
	}
	return lines
}

func ReadMatrix(path string) [][]string {
	lines := Read(path)
	m := make([][]string, len(lines))

	for i, l := range lines {
		m[i] = strings.Split(l, "")
	}
	return m
}
func ReadIntMatrix(path string) [][]int {
	lines := Read(path)
	m := make([][]int, len(lines))

	for i, l := range lines {
		m[i] = make([]int, len(l))
		for j, c := range l {
			n, _ := strconv.Atoi(string(c))
			m[i][j] = n
		}
	}
	return m
}

func ParseLine(line string) []int {
	intsStr := strings.Fields(line)
	ints := make([]int, len(intsStr))
	for i, v := range intsStr {
		number, err := strconv.Atoi(v)
		check(err)

		ints[i] = number
	}

	return ints
}

func MapAppend[E comparable, V any](m map[E][]V, k E, el V) {
	if m[k] == nil {
		m[k] = []V{el}
		return
	}
	m[k] = append(m[k], el)
}

func Print[E any](grid [][]E) {
	for _, r := range grid {
		for _, c := range r {
			fmt.Print(c)
		}
		fmt.Println()
	}
	fmt.Println()
}
