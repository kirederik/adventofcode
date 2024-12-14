package day12_test

import (
	"fmt"
	"testing"

	"github.com/kirederik/adventofcode/2024/day12"
	"gotest.tools/assert"
)

func Test_Puzzle01(t *testing.T) {
	for i, expected := range []int64{140, 772, 1930} {
		ans := day12.Puzzle01(fmt.Sprintf("input.test.%d", i))
		assert.Equal(t, ans, expected)
	}

	ansPuzzle := day12.Puzzle01("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(1486324))
}

func Test_Puzzle02(t *testing.T) {
	for i, expected := range []int64{80, 436} {
		ans := day12.Puzzle02(fmt.Sprintf("input.test.%d", i))
		assert.Equal(t, ans, expected)
	}
	ansPuzzle := day12.Puzzle02("input.puzzle")
	assert.Equal(t, ansPuzzle, int64(898684))
}
