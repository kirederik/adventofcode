package day10

import (
	"fmt"

	"github.com/kirederik/adventofcode/2024/lib"
)

type Point struct {
	i, j, v int
}

func (p Point) inBoundary(grid [][]int) bool {
	return p.i >= 0 && p.i < len(grid) && p.j >= 0 && p.j < len(grid[0])
}
func key(n Point) string {
	return fmt.Sprintf("(%d,%d)", n.i, n.j)
}

func calcScore(p Point, grid [][]int, trackVisits bool) int64 {
	var count int64
	queue := []Point{p}
	visited := map[string]bool{}
	for len(queue) > 0 {
		nextQueue := []Point{}

		for len(queue) > 0 {
			next := queue[0]
			queue = queue[1:]
			if next.v == 9 {
				count++
				continue
			}
			v := next.v + 1

			neighbours := []Point{
				{next.i - 1, next.j, v},
				{next.i + 1, next.j, v},
				{next.i, next.j - 1, v},
				{next.i, next.j + 1, v},
			}

			for _, n := range neighbours {
				if n.inBoundary(grid) && grid[n.i][n.j] == v {
					if !visited[key(n)] || !trackVisits {
						nextQueue = append(nextQueue, n)
						visited[key(n)] = true
					}
				}
			}

		}
		queue = nextQueue
	}
	return count
}

func parseInput(inputPath string) ([][]int, []Point) {
	grid := lib.ReadIntMatrix(inputPath)

	arr := []Point{}
	for i := range grid {
		for j := range grid[i] {
			if grid[i][j] == 0 {
				arr = append(arr, Point{i, j, 0})
			}
		}
	}
	return grid, arr
}

func Puzzle01(inputPath string) int64 {
	var count int64
	grid, arr := parseInput(inputPath)

	for _, p := range arr {
		count += calcScore(p, grid, true)
	}

	return count
}

func Puzzle02(inputPath string) int64 {
	var count int64
	grid, arr := parseInput(inputPath)

	for _, p := range arr {
		count += calcScore(p, grid, false)
	}

	return count
}
