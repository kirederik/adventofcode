package day14_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day14"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day14.Puzzle01("input.test", 11, 7)
	assert.Equal(t, ans, int64(12))

	ansPuzzle := day14.Puzzle01("input.puzzle", 101, 103)
	assert.Equal(t, ansPuzzle, int64(218965032))
}

func Test_Puzzle02(t *testing.T) {
	// ans := day14.Puzzle02("input.test")
	// assert.Equal(t, ans, int64(875318608908))
	ansPuzzle := day14.Puzzle02("input.puzzle", 101, 103)
	assert.Equal(t, ansPuzzle, int64(7037))
}
