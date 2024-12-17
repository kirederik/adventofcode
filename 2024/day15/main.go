package day15

import (
	"fmt"

	"github.com/kirederik/adventofcode/2024/lib"
)

func GetPositionForMove(move string) *lib.Position {
	switch move {
	case "^":
		return &lib.Position{X: -1, Y: 0}
	case "<":
		return &lib.Position{X: 0, Y: -1}
	case "v":
		return &lib.Position{X: 1, Y: 0}
	case ">":
		return &lib.Position{X: 0, Y: 1}
	}
	return nil
}

const (
	Wall     = "#"
	Robot    = "@"
	Box      = "O"
	BoxStart = "["
	BoxEnd   = "]"
	Space    = "."
)

func calculateGPS(grid [][]string) int64 {
	var gps int64
	for i := range grid {
		for j := range grid[i] {
			if grid[i][j] == Box {
				gps += int64((100 * i) + j)
			}
		}
	}
	return gps
}

func calculateExpandedGPS(grid [][]string) int64 {
	var gps int64
	for i := range grid {
		for j := range grid[i] {
			if grid[i][j] == BoxStart {
				gps += int64((100 * i) + j)
			}
		}
	}
	return gps
}

func ParseInput(inputPath string) ([][]string, []string) {
	input := lib.ReadMatrix(inputPath)
	grid := [][]string{}
	moves := []string{}
	var readingMoves bool
	for i := range input {
		if len(input[i]) == 0 {
			readingMoves = true
			continue
		}

		if readingMoves {
			moves = append(moves, input[i]...)
		} else {
			grid = append(grid, input[i])
		}
	}
	return grid, moves
}

func Expand(grid [][]string) [][]string {
	expanded := [][]string{}

	for i := range grid {
		k := 0
		expanded = append(expanded, make([]string, len(grid[i])*2))
		for j := range grid[i] {
			switch grid[i][j] {
			case Box:
				expanded[i][k] = BoxStart
				expanded[i][k+1] = BoxEnd
			case Robot:
				expanded[i][k] = Robot
				expanded[i][k+1] = Space
			default:
				expanded[i][k] = grid[i][j]
				expanded[i][k+1] = grid[i][j]
			}

			k += 2
		}
	}
	return expanded

}

func moveHorizontally(curr *lib.Position, prev *lib.Position, grid [][]string, move string) error {
	currVal := Get(grid, curr)

	nextPos := curr.Add(GetPositionForMove(move))

	offset := 1
	switch currVal {
	case Wall:
		return fmt.Errorf("can't move")
	case BoxEnd:
		offset = -1
		fallthrough
	case BoxStart:
		if currVal == BoxStart || currVal == BoxEnd {
			if err := moveHorizontally(nextPos, curr, grid, move); err != nil {
				return err
			}
			if err := moveHorizontally(nextPos.AddPos(0, offset), curr.AddPos(0, offset), grid, move); err != nil {
				return err
			}
		}
	}

	prevVal := Get(grid, prev)
	grid[curr.X][curr.Y] = prevVal
	grid[prev.X][prev.Y] = Space
	return nil
}

func moveVertically(b *lib.Position, grid [][]string, move string) error {
	next := GetPositionForMove(move)

	nextCell := b
	// find the next empty space
	for grid[nextCell.X][nextCell.Y] == BoxStart || grid[nextCell.X][nextCell.Y] == BoxEnd {
		nextCell = nextCell.Add(next)
	}

	if grid[nextCell.X][nextCell.Y] == Wall {
		return fmt.Errorf("can't move box")
	}

	op := next.Mul(-1)
	// move all one to the oposite direction
	prevCell := nextCell.Add(op)
	for !b.Equal(nextCell) {
		grid[nextCell.X][nextCell.Y] = grid[prevCell.X][prevCell.Y]
		nextCell = prevCell
		prevCell = prevCell.Add(op)
	}
	return nil
}

func MoveBoxes(robot, b *lib.Position, grid [][]string, move string) error {
	if grid[b.X][b.Y] == Wall {
		return fmt.Errorf("can't move box")
	}

	if move == ">" || move == "<" {
		return moveVertically(b, grid, move)
	}
	if move == "^" || move == "v" {
		return moveHorizontally(b, robot, grid, move)
	}

	return nil
}

func Get(grid [][]string, pos *lib.Position) string {
	return grid[pos.X][pos.Y]
}

func Puzzle01(inputPath string) int64 {
	grid, moves := ParseInput(inputPath)
	robot := lib.FindPosition(grid, Robot)

	for _, move := range moves {
		next := GetPositionForMove(move)

		nextPos := robot.Add(next)
		prev := robot

		switch grid[nextPos.X][nextPos.Y] {
		case Wall:
			continue
		case Box:
			box := nextPos
			for grid[box.X][box.Y] == Box {
				box = box.Add(next)
			}

			if grid[box.X][box.Y] == Wall {
				continue
			}

			grid[box.X][box.Y] = Box
			fallthrough
		default:
			robot = nextPos
		}

		grid[prev.X][prev.Y] = Space
		grid[robot.X][robot.Y] = Robot
	}

	return calculateGPS(grid)
}

func Puzzle02(inputPath string) int64 {
	grid, moves := ParseInput(inputPath)
	grid = Expand(grid)
	robot := lib.FindPosition(grid, Robot)

	for _, move := range moves {
		next := GetPositionForMove(move)

		nextPos := robot.Add(next)
		prev := robot

		switch grid[nextPos.X][nextPos.Y] {
		case Wall:
			continue
		case BoxEnd:
			fallthrough
		case BoxStart:
			oldGrid := lib.Copy(grid) // lazy restore
			if err := MoveBoxes(robot, nextPos, grid, move); err != nil {
				grid = oldGrid
				continue
			}
			fallthrough
		default:
			robot = nextPos
		}

		grid[prev.X][prev.Y] = Space
		grid[robot.X][robot.Y] = Robot
	}

	return calculateExpandedGPS(grid)
}
