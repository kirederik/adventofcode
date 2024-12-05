package day04_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day04"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day04.Puzzle01("input.test")
	assert.Equal(t, ans, 18)

	ansPuzzle := day04.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, 2591)
}

func Test_Puzzle02(t *testing.T) {
	ans := day04.Puzzle02("input.test")
	assert.Equal(t, ans, 9)

	ansPuzzle := day04.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, 1880)
}
