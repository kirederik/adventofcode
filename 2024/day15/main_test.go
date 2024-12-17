package day15_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day15"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day15.Puzzle01("input.test")
	assert.Equal(t, ans, int64(2028))

	ans = day15.Puzzle01("input.test.1")
	assert.Equal(t, ans, int64(10092))

	ansPuzzle := day15.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(1360570))
}

func Test_Puzzle02(t *testing.T) {
	ans := day15.Puzzle02("input.test.1")
	assert.Equal(t, ans, int64(9021))

	ansPuzzle := day15.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(1381446))
}
