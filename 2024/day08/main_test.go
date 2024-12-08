package day08_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day08"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day08.Puzzle01("input.test-a")
	assert.Equal(t, ans, int64(2))

	ans = day08.Puzzle01("input.test-b")
	assert.Equal(t, ans, int64(4))
	ans = day08.Puzzle01("input.test")
	assert.Equal(t, ans, int64(14))

	ansPuzzle := day08.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(376))
}

func Test_Puzzle02(t *testing.T) {
	ans := day08.Puzzle02("input.test-c")
	assert.Equal(t, ans, int64(9))

	ans = day08.Puzzle02("input.test")
	assert.Equal(t, ans, int64(34))

	ansPuzzle := day08.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(1352))
}
