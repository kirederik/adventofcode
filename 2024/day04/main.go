package day04

import (
	"github.com/kirederik/adventofcode/2024/lib"
)

func match(strs ...string) int {
	var matches int
	for _, str := range strs {
		if str == "XMAS" || str == "SAMX" {
			matches++
		}
	}
	return matches
}

func Puzzle01(inputPath string) int {
	var count int

	lines := lib.Read(inputPath)

	charMatrix := make([][]rune, len(lines))
	for i, line := range lines {
		charMatrix[i] = []rune(line)
	}

	for i := 0; i < len(charMatrix); i++ {
		l := charMatrix[i]
		for j := 0; j < len(l); j++ {
			if j+3 < len(l) {
				w := string(l[j : j+4])
				count += match(w)
			}

			var cw, dw, dw2 string
			for k := 0; k < 4; k++ {
				if i+k < len(charMatrix) {
					cw += string(charMatrix[i+k][j])

					if j+k < len(charMatrix[i+k]) {
						dw += string(charMatrix[i+k][j+k])
					}
					if j-k >= 0 {
						dw2 += string(charMatrix[i+k][j-k])
					}
				}
			}

			count += match(cw, dw, dw2)
		}
	}

	return count
}

func match2(str string) bool {
	return str == "MAS" || str == "SAM"
}

func Puzzle02(inputPath string) int {
	var count int
	lines := lib.Read(inputPath)

	charMatrix := make([][]rune, len(lines))
	for i, line := range lines {
		charMatrix[i] = []rune(line)
	}

	for i := 0; i < len(charMatrix); i++ {
		for j := 0; j < len(charMatrix[i]); j++ {
			var dw, dw2 string
			for k := 0; k < 3; k++ {
				if i+2 >= len(charMatrix) || j+2 >= len(charMatrix[i]) {
					break
				}
				dw += string(charMatrix[i+k][j+k])
				dw2 += string(charMatrix[i+k][j+2-k])
			}
			if match2(dw) && match2(dw2) {
				count++
			}

		}
	}

	return count
}
