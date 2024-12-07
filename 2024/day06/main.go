package day06

import (
	"fmt"
	"slices"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

const (
	Up    = "^"
	Right = ">"
	Down  = "v"
	Left  = "<"
)

func remove(m map[int][]int, k, v int) {
	if i := slices.Index(m[k], v); i >= 0 {
		m[k] = slices.Delete(m[k], i, i+1)
	}
}

func insert(m map[int][]int, k, v int) {
	if m[k] == nil {
		m[k] = make([]int, 0)
	}
	m[k] = append(m[k], v)
	slices.Sort(m[k])
}

type Guard struct {
	x, y int
	face string
}

func (g *Guard) Rotate() string {
	rotations := map[string]string{
		Up:    Right,
		Right: Down,
		Down:  Left,
		Left:  Up,
	}
	if next, ok := rotations[g.face]; ok {
		g.face = next
		return g.face
	}
	panic("invalid guard direction")
}

func (g *Guard) Move(grid [][]string, nextX, nextY int) {
	grid[g.x][g.y] = "X"
	grid[nextX][nextY] = g.face
	g.x = nextX
	g.y = nextY
}

func (g *Guard) GetNextPosition() (int, int) {
	offsets := map[string][2]int{
		Up:    {-1, 0},
		Right: {0, 1},
		Down:  {1, 0},
		Left:  {0, -1},
	}
	if offset, ok := offsets[g.face]; ok {
		return g.x + offset[0], g.y + offset[1]
	}
	return g.x, g.y
}

func (g *Guard) Update(grid [][]string, x, y int) {
	g.x = x
	g.y = y
	g.Rotate()
}

func isGuard(c string) bool {
	return c == Up || c == Right || c == Down || c == Left
}

func findGuard(grid [][]string) (int, int) {
	for i := range grid {
		for j := range grid[i] {
			if isGuard(grid[i][j]) {
				return i, j
			}
		}
	}
	return -1, -1
}

func withinBounds(grid [][]string, x, y int) bool {
	return x >= 0 && x < len(grid) && y >= 0 && y < len(grid[0])
}

func key(x, y int) string {
	return fmt.Sprintf("%d-%d", x, y)
}

func findNextUp(x, y int, colMap map[int][]int) (int, int) {
	t := colMap[y]
	for i := len(t) - 1; i >= 0; i-- {
		if t[i] < x {
			return t[i] + 1, y
		}
	}
	return -1, y
}

func findNextDown(x, y int, colMap map[int][]int) (int, int) {
	t := colMap[y]
	for i := 0; i < len(t); i++ {
		if t[i] > x {
			return t[i] - 1, y
		}
	}
	return -1, y
}

func findNextRight(x, y int, rowMap map[int][]int) (int, int) {
	t := rowMap[x]
	for i := 0; i < len(t); i++ {
		if t[i] > y {
			return x, t[i] - 1
		}
	}
	return x, -1
}

func findNextLeft(x, y int, rowMap map[int][]int) (int, int) {
	t := rowMap[x]
	for i := len(t) - 1; i >= 0; i-- {
		if t[i] < y {
			return x, t[i] + 1
		}
	}
	return x, -1
}

func loopDetected(grid [][]string, g Guard, rowMap, colMap map[int][]int) bool {
	visited := map[string]bool{}

	for withinBounds(grid, g.x, g.y) {
		var xn, yn int

		// find next obstruction
		switch g.face {
		case Up:
			xn, yn = findNextUp(g.x, g.y, colMap)
		case Down:
			xn, yn = findNextDown(g.x, g.y, colMap)
		case Right:
			xn, yn = findNextRight(g.x, g.y, rowMap)
		case Left:
			xn, yn = findNextLeft(g.x, g.y, rowMap)
		}

		// Check if we've hit a boundary
		if xn == -1 || yn == -1 {
			return false
		}

		id := key(xn, yn) + "-" + g.face
		if visited[id] {
			return true
		}
		visited[id] = true
		g.Update(grid, xn, yn)
	}
	return false
}

func Puzzle01(inputPath string) int {
	grid := parseInput(inputPath)

	x, y := findGuard(grid)
	guard := Guard{x: x, y: y, face: grid[x][y]}
	count := 0

	for {
		nextX, nextY := guard.GetNextPosition()

		if !withinBounds(grid, nextX, nextY) {
			break
		}

		switch grid[nextX][nextY] {
		case "#": // hit wall, rotate guard
			grid[guard.x][guard.y] = guard.Rotate()
			continue
		case ".": // unvisited empty space, count and move
			count++
			fallthrough
		default: //
			guard.Move(grid, nextX, nextY)
		}
	}

	return count + 1
}

func Puzzle02(inputPath string) int {
	grid := parseInput(inputPath)
	count := 0

	guard, rowMap, colMap := initializeMaps(grid)
	tried := map[string]bool{key(guard.x, guard.y): true}

	for {
		nextX, nextY := guard.GetNextPosition()

		if !withinBounds(grid, nextX, nextY) {
			break
		}

		if grid[nextX][nextY] == "#" {
			guard.Rotate()
			grid[guard.x][guard.y] = guard.face
			continue
		}

		if !tried[key(nextX, nextY)] { // don't try to place wall on a space we've already tried
			count += tryPlacingWall(grid, &guard, nextX, nextY, rowMap, colMap)
			tried[key(nextX, nextY)] = true
		}

		guard.Move(grid, nextX, nextY)
	}

	return count
}

func initializeMaps(grid [][]string) (Guard, map[int][]int, map[int][]int) {
	var g Guard
	rowMap := make(map[int][]int)
	colMap := make(map[int][]int)

	for r := range grid {
		for c := range grid[r] {
			charAt := grid[r][c]
			if isGuard(charAt) {
				g = Guard{x: r, y: c, face: charAt}
			}
			if charAt == "#" {
				insert(rowMap, r, c)
				insert(colMap, c, r)
			}
		}
	}

	return g, rowMap, colMap
}

func tryPlacingWall(grid [][]string, g *Guard, x, y int, rowMap, colMap map[int][]int) int {
	oldFace := g.face

	// place wall in front of guard
	grid[x][y] = "#"
	insert(colMap, y, x)
	insert(rowMap, x, y)

	grid[g.x][g.y] = g.Rotate()

	result := 0
	if loopDetected(grid, *g, rowMap, colMap) {
		result = 1
	}

	grid[x][y] = "." // restore empty space
	g.face = oldFace // restore guard direction
	remove(colMap, y, x)
	remove(rowMap, x, y)

	return result
}

func parseInput(inputPath string) [][]string {
	lines := lib.Read(inputPath)
	grid := make([][]string, len(lines))
	for i, line := range lines {
		grid[i] = strings.Split(line, "")
	}
	return grid
}
