package day03

import (
	"strconv"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

func nextNumber(input string, i int) (int, int) {
	size := 0

	n, err := strconv.Atoi(input[i : i+size+1])
	var prevN int
	for err == nil && size < 3 {
		prevN = n
		size++
		if i+size >= len(input) {
			return 0, -1
		}
		n, err = strconv.Atoi(input[i : i+size+1])
	}

	if size == 0 {
		return 0, -1
	}

	return prevN, size
}

func Puzzle02(inputPath string) int64 {
	input := strings.Join(lib.Read(inputPath), "-")

	var disabled bool

	var ans int64
	var i int
	for i < len(input) {
		if i+4 < len(input) && string(input[i:i+4]) == "do()" {
			disabled = false
			i += 4
			continue
		}

		if disabled {
			i += 1
			continue
		}

		if i+7 < len(input) && string(input[i:i+7]) == "don't()" {
			disabled = true
			i += 7
			continue
		}

		if i+4 < len(input) && string(input[i:i+4]) == "mul(" {
			i += 4

			n1, n1Size := nextNumber(input, i)
			if n1Size == -1 {
				continue
			}
			i += n1Size

			if input[i] != ',' {
				continue
			}
			i++

			n2, n2Size := nextNumber(input, i)
			if n2Size == -1 {
				continue
			}

			i += n2Size

			if input[i] != ')' {
				continue
			}

			ans += (int64(n1) * int64(n2))

		}
		i++
	}

	return ans
}
