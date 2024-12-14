package day12

import (
	"github.com/kirederik/adventofcode/2024/lib"
)

type Point struct {
	i, j int
	v    string
}

func matchPlant(grid [][]string, i, j int, plant string) bool {
	if i >= 0 && j >= 0 && i < len(grid) && j < len(grid) {
		return grid[i][j] == plant
	}
	return false
}

func getRegion(grid [][]string, i, j int) []Point {
	plant := grid[i][j]
	points := []Point{{i, j, plant}}
	grid[i][j] = "."

	for _, c := range [][]int{{i + 1, j}, {i - 1, j}, {i, j + 1}, {i, j - 1}} {
		if matchPlant(grid, c[0], c[1], plant) {
			points = append(points, getRegion(grid, c[0], c[1])...)
		}
	}

	return points
}

func area(region []Point) int64 {
	return int64(len(region))
}

func countNeighbours(p Point, grid [][]string) int64 {
	var count int64
	i := p.i
	j := p.j
	plant := p.v
	for _, c := range [][]int{
		{i + 1, j}, {i - 1, j}, {i, j + 1}, {i, j - 1},
	} {
		if matchPlant(grid, c[0], c[1], plant) {
			count++
		}
	}

	return count
}

func perimeter(region []Point, grid [][]string) int64 {
	var perimeter int64
	if len(region) == 1 {
		return 4
	}

	for i := 0; i < len(region); i++ {
		perimeter += 4 - countNeighbours(region[i], grid)
	}

	return perimeter
}

func corners(p Point, grid [][]string) int64 {
	up := matchPlant(grid, p.i-1, p.j, p.v)
	down := matchPlant(grid, p.i+1, p.j, p.v)
	right := matchPlant(grid, p.i, p.j+1, p.v)
	left := matchPlant(grid, p.i, p.j-1, p.v)
	upleft := matchPlant(grid, p.i-1, p.j-1, p.v)
	upright := matchPlant(grid, p.i-1, p.j+1, p.v)
	downleft := matchPlant(grid, p.i+1, p.j-1, p.v)
	downright := matchPlant(grid, p.i+1, p.j+1, p.v)

	var corners int64

	if !up && !left {
		corners++
	}
	if !right && !up {
		corners++
	}
	if !down && !left {
		corners++
	}
	if !down && !right {
		corners++
	}
	if up && left && !upleft {
		corners++
	}
	if down && left && !downleft {
		corners++
	}
	if up && right && !upright {
		corners++
	}
	if down && right && !downright {
		corners++
	}
	return corners
}

func sides(region []Point, grid [][]string) int64 {
	if len(region) == 1 {
		return 4
	}

	faces := int64(0)
	for i := 0; i < len(region); i++ {
		faces += corners(region[i], grid)
	}

	return faces
}

func Puzzle01(inputPath string) int64 {
	grid := lib.ReadMatrix(inputPath)

	regions := [][]Point{}
	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			if grid[i][j] == "." {
				continue
			}
			regions = append(regions, getRegion(grid, i, j))
		}
	}

	var cost int64
	grid = lib.ReadMatrix(inputPath)
	for _, region := range regions {
		cost += area(region) * perimeter(region, grid)
	}
	return cost
}

func Puzzle02(inputPath string) int64 {
	grid := lib.ReadMatrix(inputPath)

	regions := [][]Point{}
	for i := 0; i < len(grid); i++ {
		for j := 0; j < len(grid[0]); j++ {
			if grid[i][j] == "." {
				continue
			}
			regions = append(regions, getRegion(grid, i, j))
		}
	}

	var cost int64
	grid = lib.ReadMatrix(inputPath)
	for _, region := range regions {
		regionCost := area(region) * sides(region, grid)
		cost += regionCost

	}
	return cost
}
