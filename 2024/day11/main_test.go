package day11_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day11"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day11.Puzzle01("input.test")
	assert.Equal(t, ans, int64(55312))

	ansPuzzle := day11.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(203609))
}

func Test_Puzzle02(t *testing.T) {
	ans := day11.Puzzle02("input.test")
	assert.Equal(t, ans, int64(65601038650482))
	ansPuzzle := day11.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(240954878211138))
}
