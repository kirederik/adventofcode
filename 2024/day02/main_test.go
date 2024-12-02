package day02_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day02"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day02.Puzzle01("input.test")
	assert.Equal(t, ans, 2)

	ansPuzzle := day02.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, 510)
}

func Test_Puzzle02(t *testing.T) {
	ans := day02.Puzzle02("input.test")
	assert.Equal(t, ans, 5)

	ansPuzzle := day02.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, 553)
}
