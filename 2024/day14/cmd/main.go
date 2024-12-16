package main

import (
	"fmt"
	"os"
	"strconv"

	tea "github.com/charmbracelet/bubbletea"
	. "github.com/kirederik/adventofcode/2024/day14"
)

type model struct {
	robots  []Robot
	seconds int64
	x, y    int64
	grid    [][]string
}

func (m model) Init() tea.Cmd {
	// Just return `nil`, which means "no I/O right now, please."
	return nil
}

func (m model) moveRobots(vel int64) {
	for _, r := range m.robots {
		m.grid[r.PosY()][r.PosX()] = "."
	}
	MoveRobots(m.robots, m.x, m.y, vel)

	for _, r := range m.robots {
		m.grid[r.PosY()][r.PosX()] = "#"
	}
}

func (m model) Update(msg tea.Msg) (tea.Model, tea.Cmd) {
	var vel int64
	var findTree bool
	switch msg := msg.(type) {
	case tea.KeyMsg:
		switch msg.String() {
		case "ctrl+c", "q":
			return m, tea.Quit
		case "left":
			vel = -1
		case "right":
			vel = 1
		case "x":
			findTree = true
		}
	}

	if findTree {
		for !ResemblesTree(m.grid) {
			m.moveRobots(1)
			m.seconds++
		}
	} else {
		m.moveRobots(vel)
		m.seconds += vel
	}
	return m, nil
}

func (m model) View() string {
	// The header
	s := fmt.Sprintf("%d seconds elapsed...\n\n", m.seconds)
	for y := range m.y {
		for x := range m.x {
			if m.grid[y][x] != "#" {
				s += "."
			} else {
				s += "#"
			}
		}
		s += "\n"
	}

	s += "\n\nPress → to iterate, press x to find tree"
	// Send the UI for rendering
	return s
}

func initialModel(inputPath string, x, y int64) model {
	robots := ParseInput(inputPath)
	grid := make([][]string, y)
	for i := range y {
		grid[i] = make([]string, x)
	}

	m := model{
		robots: robots,
		x:      x,
		y:      y,
		grid:   grid,
	}

	for _, r := range m.robots {
		m.grid[r.PosY()][r.PosX()] = "#"
	}
	return m
}

func main() {
	inputPath := os.Args[1]
	x, _ := strconv.ParseInt(os.Args[2], 10, 64)
	y, _ := strconv.ParseInt(os.Args[3], 10, 64)
	p := tea.NewProgram(initialModel(inputPath, x, y), tea.WithAltScreen())
	if _, err := p.Run(); err != nil {
		fmt.Printf("Alas, there's been an error: %v", err)
		os.Exit(1)
	}
}
