package day08

import (
	"fmt"

	"github.com/kirederik/adventofcode/2024/lib"
)

type Point struct {
	x, y int
}

func (p *Point) String() string {
	return fmt.Sprintf("%d-%d", p.x, p.y)
}

func parseInput(inputPath string) ([][]string, map[string][]Point) {
	grid := lib.ReadMatrix(inputPath)

	antennas := map[string][]Point{}

	for i, r := range grid {
		for j, c := range r {
			if c != "." {
				lib.MapAppend(antennas, c, Point{x: i, y: j})
			}
		}
	}

	return grid, antennas
}

func abs(x, y int) int {
	diff := x - y
	if diff < 0 {
		return -1 * diff
	}
	return diff
}

func calcAntinodes(grid [][]string, limits []int, origin Point, to []Point, antinodesMap map[string]bool, echoAntinodes bool) {

	if echoAntinodes {
		antinodesMap[origin.String()] = true
	}

	for _, p := range to {
		dx := abs(origin.x, p.x)
		dy := abs(origin.y, p.y)
		antinodes := []Point{}

		from := origin
		dst := p
		if origin.x > p.x {
			from = p
			dst = origin
		}

		if from.y <= p.y {
			antinodes = []Point{
				{x: from.x - dx, y: from.y - dy},
				{x: dst.x + dx, y: dst.y + dy},
			}
			if echoAntinodes {
				from = antinodes[0]
				dst = antinodes[1]
				for from.x-dx >= 0 && from.y-dy >= 0 {
					from.x -= dx
					from.y -= dy
					antinodes = append(antinodes, from)
				}
				for dst.x+dx < limits[0] && dst.y+dy < limits[1] {
					dst.x += dx
					dst.y += dy
					antinodes = append(antinodes, dst)
				}
			}
		} else {
			antinodes = []Point{
				{x: from.x - dx, y: from.y + dy},
				{x: dst.x + dx, y: dst.y - dy},
			}

			if echoAntinodes {
				from = antinodes[0]
				dst = antinodes[1]
				for from.x-dx >= 0 && from.y+dy < limits[1] {
					from.x -= dx
					from.y += dy
					antinodes = append(antinodes, from)
				}
				for dst.x+dx < limits[0] && dst.y-dy >= 0 {
					dst.x += dx
					dst.y -= dy
					antinodes = append(antinodes, dst)
				}
			}
		}

		for _, an := range antinodes {
			if an.x >= 0 && an.x < limits[0] && an.y >= 0 && an.y < limits[1] {
				grid[an.x][an.y] = "#"
				antinodesMap[an.String()] = true
			}
		}
	}
}

func Puzzle01(inputPath string) int64 {
	grid, antennas := parseInput(inputPath)

	limits := []int{len(grid), len(grid[0])}

	antinodesMap := map[string]bool{}
	for _, pos := range antennas {
		for i := 0; i < len(pos); i++ {
			calcAntinodes(grid, limits, pos[i], pos[i+1:], antinodesMap, false)
		}
	}

	return int64(len(antinodesMap))
}

func Puzzle02(inputPath string) int64 {
	grid, antennas := parseInput(inputPath)

	limits := []int{len(grid), len(grid[0])}

	antinodesMap := map[string]bool{}
	for _, pos := range antennas {
		for i := 0; i < len(pos); i++ {
			calcAntinodes(grid, limits, pos[i], pos[i+1:], antinodesMap, true)
		}
	}

	return int64(len(antinodesMap))
}
