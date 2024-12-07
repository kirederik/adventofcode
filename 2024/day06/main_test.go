package day06_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day06"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day06.Puzzle01("input.test")
	assert.Equal(t, ans, 41)

	ansPuzzle := day06.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, 5129)
}

func Test_Puzzle02(t *testing.T) {
	ans := day06.Puzzle02("input.test")
	assert.Equal(t, ans, 6)

	ansPuzzle := day06.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, 1888)
}
