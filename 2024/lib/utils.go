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
	return lines[:len(lines)-1]
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
