package day13_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day13"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	ans := day13.Puzzle01("input.test")
	assert.Equal(t, ans, int64(480))

	ansPuzzle := day13.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(36250))
}

func Test_Puzzle02(t *testing.T) {
	ans := day13.Puzzle02("input.test")
	assert.Equal(t, ans, int64(875318608908))
	ansPuzzle := day13.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(83232379451012))
}
