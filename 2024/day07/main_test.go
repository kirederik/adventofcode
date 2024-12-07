package day07_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day07"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day07.Puzzle01("input.test")
	assert.Equal(t, ans, int64(3749))

	ansPuzzle := day07.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(7710205485870))
}

func Test_Puzzle02(t *testing.T) {
	ans := day07.Puzzle02("input.test")
	assert.Equal(t, ans, int64(11387))

	ansPuzzle := day07.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(20928985450275))
}
