package day09_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day09"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day09.Puzzle01("input.test")
	assert.Equal(t, ans, int64(1928))

	ansPuzzle := day09.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(6200294120911))
}

func Test_Puzzle02(t *testing.T) {
	ans := day09.Puzzle02("input.test")
	assert.Equal(t, ans, int64(2858))

	ansPuzzle := day09.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(6227018762750))
}
