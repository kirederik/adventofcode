package day14

import (
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

type Position struct {
	x, y int64
}

type Velocity struct {
	x, y int64
}

type Robot struct {
	pos Position
	vel Velocity
}

func (r Robot) PosY() int64 {
	return r.pos.y
}
func (r Robot) PosX() int64 {
	return r.pos.x
}

func ParseInput(inputPath string) []Robot {
	input := lib.Read(inputPath)

	games := []Robot{}
	parseRobot := func(line string) Robot {
		entries := strings.Split(line, " ")
		positions := strings.Split(strings.Split(entries[0], "=")[1], ",")
		velocities := strings.Split(strings.Split(entries[1], "=")[1], ",")
		ps := lib.ParseInts(positions)
		vs := lib.ParseInts(velocities)
		return Robot{pos: Position{ps[0], ps[1]}, vel: Velocity{vs[0], vs[1]}}
	}

	for i := 0; i < len(input); i++ {
		games = append(games, parseRobot(input[i]))
	}

	return games
}

func MoveRobots(robots []Robot, x, y int64, seconds int64) {
	mod := func(a, b int64) int64 {
		return (a%b + b) % b
	}
	for i := range robots {
		robots[i].pos.x += robots[i].vel.x * seconds
		robots[i].pos.y += robots[i].vel.y * seconds

		robots[i].pos.x = mod(robots[i].pos.x, x)
		robots[i].pos.y = mod(robots[i].pos.y, y)
	}
}

func findQuadrants(robots []Robot, x, y int64) map[int]int {
	midX := x / 2
	midY := y / 2

	quadrants := map[int]int{}

	for i := range robots {
		if robots[i].pos.x == midX || robots[i].pos.y == midY {
			continue
		}
		if robots[i].pos.x < midX && robots[i].pos.y < midY {
			quadrants[0]++
		}
		if robots[i].pos.x > midX && robots[i].pos.y < midY {
			quadrants[1]++
		}
		if robots[i].pos.x < midX && robots[i].pos.y > midY {
			quadrants[2]++
		}
		if robots[i].pos.x > midX && robots[i].pos.y > midY {
			quadrants[3]++
		}
	}

	return quadrants
}

func solve(inputPath string, x, y, seconds int64) int64 {
	robots := ParseInput(inputPath)

	MoveRobots(robots, x, y, seconds)

	quadrants := findQuadrants(robots, x, y)
	var factor int64 = 1
	for _, r := range quadrants {
		factor *= int64(r)
	}
	return factor
}

func Puzzle01(inputPath string, x, y int64) int64 {
	return solve(inputPath, x, y, 100)
}

func ResemblesTree(grid [][]string) bool {
	y := len(grid)
	x := len(grid[0])
	var count int
	for i := range y {
		for j := 0; j < x-1; j++ {
			if grid[i][j] == "#" && grid[i][j+1] == "#" { // find a row with many consecutive robots
				count++
				if count > 20 { // random number from experimentation lol
					return true
				}
			} else {
				count = 0
			}
		}
	}
	return false
}

func Puzzle02(inputPath string, x, y int64) int64 {
	robots := ParseInput(inputPath)

	var seconds int64
	grid := make([][]string, y)
	for i := range y {
		grid[i] = make([]string, x)
	}
	for _, r := range robots {
		grid[r.PosY()][r.PosX()] = "#"
	}

	for !ResemblesTree(grid) {
		for _, r := range robots {
			grid[r.PosY()][r.PosX()] = "."
		}
		MoveRobots(robots, x, y, 1)
		seconds++
		for _, r := range robots {
			grid[r.PosY()][r.PosX()] = "#"
		}

		if seconds > 100000 {
			break //avoid infinite loop
		}
	}
	return seconds
}
