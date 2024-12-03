package day03_test

import (
	"testing"

	"github.com/kirederik/adventofcode/2024/day03"
	"gotest.tools/assert"
)

func Test_Puzzle02(t *testing.T) {
	// ans := day03.Puzzle02("input.test")
	// assert.Equal(t, ans, int64(48))

	ansPuzzle := day03.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(127092535))
}
