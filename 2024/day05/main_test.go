package day05_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day05"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day05.Puzzle01("input.test")
	assert.Equal(t, ans, 143)

	ansPuzzle := day05.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, 6951)
}

func Test_Puzzle02(t *testing.T) {
	ans := day05.Puzzle02("input.test")
	assert.Equal(t, ans, 123)

	ansPuzzle := day05.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, 4121)
}
