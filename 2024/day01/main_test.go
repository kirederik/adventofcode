package day01_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day01"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day01.Puzzle01("input.test")
	assert.Equal(t, ans, 11)

	ansPuzzle := day01.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, 2970687)
}

func Test_Puzzle02(t *testing.T) {
	ans := day01.Puzzle02("input.test")
	assert.Equal(t, ans, 31)

	ansPuzzle := day01.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, 23963899)
}
