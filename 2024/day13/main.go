package day13

import (
	"strconv"
	"strings"

	"github.com/kirederik/adventofcode/2024/lib"
)

type Position struct {
	X, Y int64
}

type Button struct {
	X, Y int64
}

type Game struct {
	A     Button
	B     Button
	Prize Position
}

func parseInput(inputPath string, offset int64) []Game {
	input := lib.Read(inputPath)

	games := []Game{}
	parseButton := func(line string) Button {
		entries := strings.Split(line, ":")
		axis := strings.Split(entries[1], ",")
		x, _ := strconv.ParseInt(strings.Split(axis[0], "+")[1], 10, 64)
		y, _ := strconv.ParseInt(strings.Split(axis[1], "+")[1], 10, 64)
		return Button{X: x, Y: y}
	}
	parsePrize := func(line string) Position {
		entries := strings.Split(line, ":")
		axis := strings.Split(entries[1], ",")
		x, _ := strconv.ParseInt(strings.Split(axis[0], "=")[1], 10, 64)
		y, _ := strconv.ParseInt(strings.Split(axis[1], "=")[1], 10, 64)
		return Position{X: x + offset, Y: y + offset}
	}

	for i := 0; i < len(input); i += 4 {
		buttonA := parseButton(input[i])
		buttonB := parseButton(input[i+1])
		prize := parsePrize(input[i+2])
		games = append(games, Game{buttonA, buttonB, prize})
	}

	return games
}

func solveEquation(a Button, b Button, p Position) (int64, int64) {
	var aPress, bPress int64

	/*
		System of equations

		1: a.X*A + b.X*B = p.X
		2: a.Y*A + b.Y*B = p.Y

		  Isolate A on equation 1
		  a.X*A = p.X - b.X*B
		  A = (p.X - b.X*B) / a.X

		  Subsititue A on equation 2
		  a.Y * (p.X - b.X*B)/a.X + b.Y*B = p.Y

		  Isolate B
		  (a.Y*p.X - b.Y*b.X*B)/a.X + b.Y*B = p.Y
		  a.Y*p.X - b.Y*b.X*B + b.Y*B*a.X = p.Y*a.X

		  B*(b.Y*b.X + b.Y*a.X) = p.Y*a.x - a.Y*p.X
		  B = (p.Y*a.X - p.X*a.Y)/(b.Y*b.X + b.Y*a.X)

		  Solve for A
		  A = (p.X - b.X*B) / a.X
	*/

	bPress = (a.X*p.Y - a.Y*p.X) / (a.X*b.Y - a.Y*b.X)
	aPress = (p.X - b.X*bPress) / a.X

	if a.X*aPress+b.X*bPress == p.X && a.Y*aPress+b.Y*bPress == p.Y {
		return aPress, bPress
	}

	return -1, -1
}

func solve(inputPath string, offset int64) int64 {
	var cost int64

	games := parseInput(inputPath, offset)

	for _, game := range games {
		aPress, bPress := solveEquation(game.A, game.B, game.Prize)
		if aPress < 0 || bPress < 0 {
			continue
		}

		cost += aPress*3 + bPress
	}

	return cost
}

func Puzzle01(inputPath string) int64 {
	return solve(inputPath, 0)
}

func Puzzle02(inputPath string) int64 {
	return solve(inputPath, 10000000000000)
}
