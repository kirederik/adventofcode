package day10_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day10"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day10.Puzzle01("input.test")
	assert.Equal(t, ans, int64(36))

	ansPuzzle := day10.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(430))
}

func Test_Puzzle02(t *testing.T) {
	ans := day10.Puzzle02("input.test")
	assert.Equal(t, ans, int64(81))
	ansPuzzle := day10.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(928))
}
